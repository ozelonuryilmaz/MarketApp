//
//  MainTabbarController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum MainTabbarItemPosition: Int {
    case listing = 0
    case cart = 1
    case favorite = 2
    case profile = 3
    case none = -1
}

final class MainTabbarController: UITabBarController {

    private lazy var customTabbar: MarketTabBar = {
        let t = MarketTabBar(frame: tabBar.frame)
        t.makeDefaultAppStyle()
        return t
    }()

    private var tabbarControllerDelegate: UITabBarControllerDelegate?
    private var lastSelectedTabItemPosition: MainTabbarItemPosition = .none

    init(tabbarControllerDelegate: UITabBarControllerDelegate?) {
        self.tabbarControllerDelegate = tabbarControllerDelegate
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabbar, forKey: "tabBar")
        view.backgroundColor = .white
        self.delegate = self.tabbarControllerDelegate
    }

    func changeTabbarItemController(position: MainTabbarItemPosition) {
        self.selectedIndex = position.rawValue

        self.lastSelectedTabItemPosition = position
    }
}

// MARK: Tabbar Methods
extension MainTabbarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx,
            let imageView = tabBar.subviews[idx].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }

        imageView.bounceAnimation()

        let selectedTabItemPosition = MainTabbarItemPosition(rawValue: idx) ?? .none
        self.lastSelectedTabItemPosition = selectedTabItemPosition
    }
}
