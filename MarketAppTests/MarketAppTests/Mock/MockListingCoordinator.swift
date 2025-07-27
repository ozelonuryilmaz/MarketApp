//
//  MockListingCoordinator.swift
//  MarketAppTests
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit
@testable import MarketApp

final class MockListingCoordinator: IListingCoordinator {
    
    var didCallPushDetail = false
    var didCallPresentFilter = false
    
    func pushListingDetailViewController(params: ListingDetailParams) {
        didCallPushDetail = true
    }
    
    func presentFilterViewController() {
        didCallPresentFilter = true
    }
    
    func currentNavigationController() -> UINavigationController {
        return UINavigationController()
    }
    
    func coordinate(to coordinator: Coordinator) {
        // no-op
    }
    
    func pop(animated: Bool) {
        // no-op
    }
    
    func popToRoot(animated: Bool) {
        // no-op
    }
}
