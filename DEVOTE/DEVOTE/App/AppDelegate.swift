//
//  AppDelegate.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 25/02/2022.
//

import UIKit
import Firebase
import FirebaseDynamicLinks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
