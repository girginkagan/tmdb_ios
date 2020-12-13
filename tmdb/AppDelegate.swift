//
//  AppDelegate.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SVProgressHUD.setForegroundColor(.black)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = HomeRouterInput().view(entryEntity: HomeEntryEntity())
        window?.makeKeyAndVisible()
        
        return true
    }
}

