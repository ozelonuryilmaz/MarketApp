//
//  UIScreen+Extension.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

extension UIScreen {

    /// The screen size
    class var size: CGSize {
        return UIScreen.main.bounds.size
    }

    /// The screen's width
    class var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    /// The screen's height
    class var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    /// The screen's DPI size
    class var dpiSize: CGSize {
        let size: CGSize = UIScreen.main.bounds.size
        let scale: CGFloat = UIScreen.main.scale
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
}
