//
//  AppDelegate.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }


}

