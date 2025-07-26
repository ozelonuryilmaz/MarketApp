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
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        startAppCoordinator()
        
        return true
    }
}

// MARK: Helper funcs
private extension AppDelegate {

    func startAppCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window)
        self.window = window

        self.appCoordinator.start()
    }
}

