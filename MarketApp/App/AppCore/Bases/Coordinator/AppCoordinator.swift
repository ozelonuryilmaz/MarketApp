//
//  AppCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

protocol AppCoordinatorFlow: AnyObject {

    func start()
}

class AppCoordinator: RootableCoordinator, AppCoordinatorFlow {
    
    var callbackIsPreparedMainScreen: (() -> Void)?
    
    override func start() {
        let tabbarCoordinator = MainTabbarCoordinator(window: self.window)
        tabbarCoordinator.callbackIsPreparedMainScreen = callbackIsPreparedMainScreen
        tabbarCoordinator.start()
    }
}
