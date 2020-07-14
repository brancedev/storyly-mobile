import Storyly
import UIKit

public class FlutterStorylyViewFactory: NSObject, FlutterPlatformViewFactory {
    private let registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterStorylyView(frame, viewId: viewId, args: args as? [String : Any] ?? [:], messenger: self.registrar.messenger())
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

public class FlutterStorylyView: NSObject, FlutterPlatformView, StorylyDelegate, StorylyDynamicSegmentationCallback {
    
    private let ARGS_STORYLY_ID = "storylyId"
    private let ARGS_STORY_GROUP_ICON_BORDER_COLOR_SEEN = "storyGroupIconBorderColorSeen"
    private let ARGS_STORY_GROUP_ICON_BORDER_COLOR_NOT_SEEN = "storyGroupIconBorderColorNotSeen"
    private let ARGS_STORY_GROUP_ICON_BACKGROUND_COLOR = "storyGroupIconBackgroundColor"
    private let ARGS_STORY_GROUP_TEXT_COLOR = "storyGroupTextColor"
    private let ARGS_STORY_GROUP_PIN_ICON_COLOR = "storyGroupPinIconColor"
    private let ARGS_STORY_ITEM_ICON_BORDER_COLOR = "storyItemIconBorderColor"
    private let ARGS_STORY_ITEM_TEXT_COLOR = "storyItemTextColor"
    private let ARGS_STORY_ITEM_PROGRESS_BAR_COLOR = "storyItemProgressBarColor"
    private let ARGS_STORY_GROUP_SIZE = "storyGroupSize"
    private let ARGS_CUSTOM_PARAMETER = "customParameter"
    private let ARGS_SEGMENTS = "segments"

    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private let methodChannel: FlutterMethodChannel
    
    private lazy var storylyViewController:UIViewController = UIViewController()
    private lazy var storylyView: StorylyView = StorylyView(frame: self.frame)

    init(_ frame: CGRect, viewId: Int64, args: [String: Any], messenger: FlutterBinaryMessenger) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
        self.methodChannel = FlutterMethodChannel(name: "com.appsamurai.storyly/flutter_storyly_view_\(viewId)", binaryMessenger: messenger)
        super.init()
        
        setupMethodChannel()
        setupStorylyView()
    }

    public func view() -> UIView {
        return self.storylyViewController.view
    }
    
    public func filter(storylyGroupItemSegments: Set<String>?, segments: Set<String>?) -> Bool {
        self.methodChannel.invokeMethod("dynamicSegmentationCallback", arguments: ["storylyGroupItemSegments": Array<String>(storylyGroupItemSegments ?? Set<String>()), "segments": Array<String>(segments ?? Set<String>())]);
        return true
    }
    
    private func setupMethodChannel() {
        self.methodChannel.setMethodCallHandler { [weak self] call, result in
            switch call.method {
                case "refresh": self?.storylyView.refresh()
                case "show": self?.storylyView.present(animated: false)
                case "dismiss": self?.storylyView.dismiss(animated: false)
                default: do { }
            }
        }
    }
    
    private func setupStorylyView() {
        let segmentsArray = args[ARGS_SEGMENTS] as? Array<String>
        if (segmentsArray != nil) {
            let segmentation = Storyly.StorylySegmentation(segments: Set<String>(segmentsArray!), isDynamicSegmentationEnabled: true, dynamicSegmentationCallback: self)
            storylyView.storylyInit = Storyly.StorylyInit(storylyId: args[ARGS_STORYLY_ID] as? String ?? "", segmentation: segmentation, customParameter: args[ARGS_CUSTOM_PARAMETER] as? String ?? nil)
        } else {
            let segmentation = Storyly.StorylySegmentation(segments: nil)
            storylyView.storylyInit = Storyly.StorylyInit(storylyId: args[ARGS_STORYLY_ID] as? String ?? "", segmentation: segmentation, customParameter: args[ARGS_CUSTOM_PARAMETER] as? String ?? nil)
        }
        let rootViewController = (UIApplication.shared.delegate?.window??.rootViewController)!
        storylyView.delegate = self
        storylyView.rootViewController = rootViewController
        self.updateThemeFor(storylyView: storylyView, args: args)
        storylyView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        storylyView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.storylyViewController.view = storylyView
        self.storylyViewController.view.frame = self.frame
        
        rootViewController.addChildViewController(self.storylyViewController)
    }
    
    private func updateThemeFor(storylyView: StorylyView, args: [String: Any]) {
        if let storyGroupIconBorderColorSeen = self.args[ARGS_STORY_GROUP_ICON_BORDER_COLOR_SEEN] as? [String] {
            storylyView.storyGroupIconBorderColorSeen = storyGroupIconBorderColorSeen.map{ UIColor(hexString: $0) }
        }
        
        if let storyGroupIconBorderColorNotSeen = self.args[ARGS_STORY_GROUP_ICON_BORDER_COLOR_NOT_SEEN] as? [String] {
            storylyView.storyGroupIconBorderColorNotSeen = storyGroupIconBorderColorNotSeen.map{ UIColor(hexString: $0) }
        }
        
        if let storyGroupSize = self.args[ARGS_STORY_GROUP_SIZE] as? Int {
            switch storyGroupSize {
            case 0:
                storylyView.storyGroupSize = "small"
            case 1:
                storylyView.storyGroupSize = "large"
            case 2:
                storylyView.storyGroupSize = "xlarge"
            default:
                storylyView.storyGroupSize = "large"
            }
        }
        
        if let storyGroupTextColor = self.args[ARGS_STORY_GROUP_TEXT_COLOR] as? String {
            storylyView.storyGroupTextColor = UIColor.init(hexString: storyGroupTextColor)
        }
        
        if let storyGroupIconBackgroundColor = self.args[ARGS_STORY_GROUP_ICON_BACKGROUND_COLOR] as? String {
            storylyView.storyGroupIconBackgroundColor = UIColor.init(hexString: storyGroupIconBackgroundColor)
        }
        
        if let storyGroupPinIconColor = self.args[ARGS_STORY_GROUP_PIN_ICON_COLOR] as? String {
            storylyView.storyGroupPinIconColor = UIColor.init(hexString: storyGroupPinIconColor)
        }
        
        if let storyItemIconBorderColor = self.args[ARGS_STORY_ITEM_ICON_BORDER_COLOR] as? [String] {
            storylyView.storyItemIconBorderColor = storyItemIconBorderColor.map{ UIColor(hexString: $0) }
        }
        
        if let storyItemTextColor = self.args[ARGS_STORY_ITEM_TEXT_COLOR] as? String {
            storylyView.storyItemTextColor = UIColor.init(hexString: storyItemTextColor)
        }
        
        if let storyItemProgressBarColor = self.args[ARGS_STORY_ITEM_PROGRESS_BAR_COLOR] as? [String] {
            storylyView.storylyItemProgressBarColor = storyItemProgressBarColor.map{ UIColor(hexString: $0) }
        }
    }
}

extension FlutterStorylyView {
    public func storylyLoaded(_ storylyView: Storyly.StorylyView, storyGroupList: [Storyly.StoryGroup]) {
        self.methodChannel.invokeMethod("storylyLoaded", arguments: storyGroupList.map { storyGroup in
            ["index": storyGroup.index,
             "title": storyGroup.title,
             "stories": storyGroup.stories.map { story in
                ["index": story.index,
                 "title": story.title,
                 "media": ["type": story.media.type.rawValue,
                           "url": story.media.url,
                           "actionUrl": story.media.actionUrl!]]
            }]
        })
    }
    
    public func storylyLoadFailed(_ storylyView: Storyly.StorylyView, errorMessage: String) {
        self.methodChannel.invokeMethod("storylyLoadFailed", arguments: errorMessage)
    }
    
    public func storylyActionClicked(_ storylyView: Storyly.StorylyView, rootViewController: UIViewController, story: Storyly.Story) -> Bool {
        self.methodChannel.invokeMethod("storylyActionClicked",
                                        arguments: ["index": story.index,
                                                    "title": story.title,
                                                    "media": ["type": story.media.type.rawValue,
                                                              "url": story.media.url,
                                                              "actionUrl": story.media.actionUrl!]])
        return true
    }
    
    public func storylyStoryPresented(_ storylyView: Storyly.StorylyView) {
        self.methodChannel.invokeMethod("storylyStoryPresented", arguments: nil)
    }
    
    public func storylyStoryDismissed(_ storylyView: Storyly.StorylyView) {
        self.methodChannel.invokeMethod("storylyStoryDismissed", arguments: nil)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...])
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 1
        scanner.scanHexInt64(&hexNumber)
        
        let red, green, blue, alpha: CGFloat
        if hexString.count == 9 {
            alpha = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            red = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x000000ff) / 255
        } else {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x0000ff) / 255
            alpha = 1
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
