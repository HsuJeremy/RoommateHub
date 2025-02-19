//
//  AppDelegate.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 11/27/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
    
    // Customizing fonts from Hacking with Swift
    let attrs = [
      NSAttributedString.Key.font: UIFont(name: "SF Pro Display", size: 18)!
    ]
    UINavigationBar.appearance().titleTextAttributes = attrs
    UIBarButtonItem.appearance().setTitleTextAttributes(attrs, for: .normal)
    
    FirebaseApp.configure()
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }

  func application(
    _ application: UIApplication,
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>
  ) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called
    // shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they
    // will not return.
  }
}

