# Digiteka InStream Framework

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

# Installation

Simply add the dependency to your project using one of this solution:

## CocoaPods

You can use [CocoaPods](https://cocoapods.org/) to install `InStreamSDK` by adding it to your `Podfile`:

`pod 'InStreamSDK', '~> 1.0.1'`

## Swift Package Manager

You can integrate `InStreamSDK` as a Swift package by adding the following URL to the public package repository that you can add in Xcode:

`git@bitbucket.org:beappers/digiteka.instream.xcframework.git`

# Usage

Then in the `application(_:, didFinishLaunchingWithOptions:)` of your `ApplicationDelegate` class, add the following code to initialize the SDK:

    do {
        try InStream.shared.initialize(config: DTKISConfig(apiKey: "01357940"))
    } catch {
        print("Can't init InStream with error \(error.localizedDescription)")
    }

## Logger

Optionally, you can set a custom logger in order to retrieve logs from the SDK. The logger must implement the `DTKISLoggerDelegate` protocol:

    extension AppDelegate: DTKISLoggerDelegate {
        func InStreamWarn(message: String) {
            print("warn " + message)
        }
        
        func InStreamError(message: String, error: Error?) {
            print("error " + message, error as Any)
        }
    }
    
Then pass the logger:

    InStream.shared.setLoggerDelegate(self)
    
## Configs

### DTKISConfig
- mdtk (String) : api key
- debugMode (Boolean) : optional

### DTKISMainPlayerConfig
- zone (String) : zone of the website in which the video is
- src (String) : ID of the video you want to play
- urlreferrer (String) : URL of the Desktop article (URL referrer)
- gdprconsentstring (String) : user consent string
- tagparam (String) : optional advertisement params
- playMode (PlayMode): .user : user must tap to play, .auto : autoplay when loaded, .scroll : scroll 50% to play auto

### DTKISVisiblePlayerConfig
- playerPosition (VisiblePlayerPosition) : position of the visible player (TOP_START, TOP_END, BOTTOM_START, BOTTOM_END)
- widthPercent (WidthProportion) : width of the player in percentage of the parentView
- ratio (Ratio) : ratio of the video player width / height
- horizontalMargin (CGFloat) : margin of the visible player
- verticalMargin (CGFloat) : margin of the visible player

## MainPlayerView (UIKIT)

Create an instance of `MainPlayerView` by calling : 
    
    var myMainPlayerView: MainPlayerView?
    let myConfig: DTKISMainPlayerConfig = ... your config
    
    do {
        try myMainPlayerView = InStream.shared.initMainPlayerWith(config: myConfig) 
    } catch {
        // it may throw an error if not initialized correctly
    }

Then put it in the containerview (which can be a UIView in a UITableViewCell, or just an UIView) by calling : 

    myMainPlayerView?.setIn(containerView: myContainerView)
    
## If playMode is set to scroll to 50% (UIKIT)

In your UIViewController, keep an instance of the MainPlayerView
Then use this extension of UIScrollView :

    extension MyViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            if let myMainPlayerView = myMainPlayerCell.myMainPlayerView {
            
                myMainPlayerView.viewDidScroll(scrollView: scrollView)
            }
        }
    }

## VisiblePlayer (UIKIT)

In your UIViewController

    var visiblePlayer: VisiblePlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myConfig: DTKISVisiblePlayerConfig = ... your config
        
        myVisiblePlayer = InStream.shared.initVisiblePlayerWith(config: myConfig, in: self.view, scrollView: scrollView)
    }
    
    
    extension MyViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            if let myMainPlayerCell = myMainPlayerCell, let myMainPlayerView = myMainPlayerCell.mainPlayerView {
            
                visiblePlayer?.viewDidScroll(mainPlayerView: myMainPlayerView)
            }
        }
    }

## MainPlayer and VisiblePlayer (SwiftUI)

If you just want an instance of the MainPlayer (with playMode = .auto or .user), you can simply call
 
    InStream.shared.initMainPlayerRepresentable(config: DTKISMainPlayerConfig)
    
It returns a View you can use in a ScrollView
    

If you plan to use any other functionality such as : visiblePlayer or playMode = .scroll, 
then you must use `InStreamScrollVStack`, a ScrollView in which you can add you content

        InStreamScrollVStack(config: mainPlayerConfig, visiblePlayerConfig: visiblePlayerConfig, data: mockData, playerInsertPosition: 10) { element in
            Text("element.id")
                .fixedSize(horizontal: false, vertical: true)
        }
        
The visiblePlayerConfig can be nil if you don't need visiblePlayer

## Errors and Logs

| Type          | Error Code   | Level    | Message                                                                                                                                    | Cause
|---------------|--------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|     
| Configuration | DTKIS_CONF_3 | Error    | InStream sdk has not yet been initialized. Please call `InStream.shared.initialize` first.                                                 | `InStream.shared.initialize` has not been called yet        


