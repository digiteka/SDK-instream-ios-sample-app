//
//  AppDelegate.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import UIKit
import InStreamSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try InStream.shared.initialize(config: DTKISConfig(mdtk: Constants.mdtk))
        } catch {
            print("Can't init InStream with error \(error.localizedDescription)")
        }
        InStream.shared.setLoggerDelegate(self)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// MARK: DTKNSLoggerDelegate
extension AppDelegate: DTKISLoggerDelegate {
    func InStreamDebug(message: String) {
        print("debug " + message)
    }

    func InStreamInfo(message: String) {
        print("info " + message)
    }

    func InStreamWarn(message: String) {
        print("warn " + message)
    }

    func InStreamError(message: String, error: Error?) {
        print("error " + message, error as Any)
    }
}
