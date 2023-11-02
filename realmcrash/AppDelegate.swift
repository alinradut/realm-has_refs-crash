//
//  AppDelegate.swift
//  realmcrash
//
//  Created by Alin Radut on 11/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundTaskId: UIBackgroundTaskIdentifier?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

        backgroundTaskId = UIApplication.shared.beginBackgroundTask { [weak self] in
            if let backgroundTaskId = self?.backgroundTaskId {
                print("ended background task: \(backgroundTaskId)")
                UIApplication.shared.endBackgroundTask(backgroundTaskId)
            }
            self?.backgroundTaskId = nil
        }
        print("began background task: \(backgroundTaskId!)")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let backgroundTaskId {
            UIApplication.shared.endBackgroundTask(backgroundTaskId)
            self.backgroundTaskId = nil
        }
    }
}

