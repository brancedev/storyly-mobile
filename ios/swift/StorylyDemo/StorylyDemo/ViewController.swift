//
//  ViewController.swift
//  StorylyDemo
//
//  Created by Levent ORAL on 25.09.2019.
//  Copyright © 2019 App Samurai Inc. All rights reserved.
//

import UIKit
import Storyly

class ViewController: UIViewController {

    @IBOutlet weak var storylyView: StorylyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.storylyView.storylyInit = StorylyInit(storylyId: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjExNzIsImFwcF9pZCI6Nzg0LCJpbnNfaWQiOjc4MX0.YxMpnoqNPx8rnUjRT1_7ql4zcpsoDwbX9bJryhGQqPA") 
        self.storylyView.rootViewController = self
        self.storylyView.delegate = self
    }
}

extension ViewController: StorylyDelegate {
    func storylyLoaded(_ storylyView: StorylyView, storyGroupList: [StoryGroup]) {
        print("storylyLoaded")
    }
    
    func storylyLoadFailed(_ storylyView: StorylyView, errorMessage: String) {
        print("storylyLoadFailed")
    }
    
    func storylyActionClicked(_ storylyView: Storyly.StorylyView, rootViewController: UIViewController, story: Storyly.Story) -> Bool {
        print("storylyActionClicked")
        return true // return false if sdk should handle click
    }
    
    func storylyStoryPresented(_ storylyView: StorylyView) {
        print("storylyStoryPresented")
    }
    
    func storylyStoryDismissed(_ storylyView: StorylyView) {
        print("storylyStoryDismissed")
    }
}
