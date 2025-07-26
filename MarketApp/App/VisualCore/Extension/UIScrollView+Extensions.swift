//
//  UIScrollView+Extensions.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

extension UIScrollView {
    
    var isAvailablePagination: Bool {
        if contentSize.height == 0 { return false }
        let height = frame.size.height
        let contentYoffset = contentOffset.y
        let distanceFromBottom = contentSize.height - contentYoffset
        return distanceFromBottom < height
    }
}
