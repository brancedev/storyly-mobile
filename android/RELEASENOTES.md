# Release Notes
### 1.5.2
* added 'xlarge' story group size 
* added storyGroupIconForegroundColors method for 'xlarge' story groups gradient layer
* added storyGroupTextTypeface method
* added 'customParameter' parameter to StorylyInit to pass customized field for users

### 1.5.1
* fixed jagged edges in interactive poll component
* fixed a bug for rotated interactive action button
* increased padding size for rotated interactive action button

### 1.5.0
* added interactive stories support for poll
* updated placement of emoji reaction view

### 1.4.2
* fixed rare crash that occurs when story completes

### 1.4.1
* added 'Sponsored' indicator for ad story groups
* improved ad place calculation for better user experience
* fixed user experience for some native ad types

### 1.4.0
* added client side ad insertion flow
* fixed crash that occurs when deactivated story is opened with deeplink

### 1.3.1
* IMPORTANT! changed StorylyInit class definitions, please check README
* fixed a rare bug during transitions
* fixed crash during empty story group list scroll

### 1.3.0
* IMPORTANT! removed storylyId with storylyInit parameter, please check README
* IMPORTANT! changed openStory method signature, please check README
* added setExternalData api to extend personalized usage, please check Advanced Topics
* added segmentation of story groups
* added dynamic/runtime segmentation of story groups, please check Advanced Topics
* added 'large'(default one) and 'small' story group size 

### 1.2.1
* fix crash during deeplink openings

### 1.2.0
* Performance improvements on story transitions
* Added capability to open stories using deeplink generated from dashboard
* [Segmentify](https://www.segmentify.com/) integration to show personalized stories to users

### 1.1.0
* add interactive stories support for custom button action, text and emoji reaction

### 1.0.2
* improvements on placement for different device ratio including tablets

### 1.0.1
* improvements on placement for different device ratio
* fix orientation calculation issue

### 1.0.0
* IMPORTANT! change storylyLoad callback signature, please check README
* IMPORTANT! change storylyLoadFailed callback signature, please check README
* add storylyStoryShown and storylyStoryDismissed callbacks
* add show and dismis api
* rename StorylyData to StoryData
* improvements on cutout handling
* improvements on pull down and overscroll animations
* fix video black screen issue on some Samsung devices

### 0.0.22
* improvements on multiline textview

### 0.0.21
* improvements for phones with cutout display area(notch)
* add multiple instance support

### 0.0.20
* add animation for over scroll 
* improvements on video playback
* fix restoreInstance issue

### 0.0.19
* add pull down for close story
* add animation for transition between story groups
* fix android:nestedScrollingEnabled issue

### 0.0.18
* improvements on video story

### 0.0.15
* update icons for better UI
* fix action text case issue (uppercased by default)

### 0.0.14
* add UI customization APIs, please check README for details
* add pinned story flow
* improve story loading for better UX
* change action view icons
* fix progress bar style for older versions

### 0.0.13
* improvements on gestures

### 0.0.11
* add skeleton view for loading cases
* change storylyActionClicked delegate signature 
* ui changes
* fix video story playback
* add story title
* improvements on gestures

### 0.0.8
* add cubic animation to story transititon
* handle orientation changes

### 0.0.7
* add refresh API
* add story seen state handling
* add duration configuration from backend; current configuration is 7sec for image type stories, 15sec for video types

### 0.0.6
* add storylyActionClicked callback
