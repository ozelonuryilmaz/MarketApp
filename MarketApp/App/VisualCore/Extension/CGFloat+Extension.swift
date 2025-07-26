//
//  CGFloat+Extension.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

extension CGFloat {

    func adjustWidthRespectToDesignRate() -> CGFloat {
        let designRate = 375 / self
        let value = UIScreen.width / designRate
        return value
    }

    func adjustHeightRespectToDesignRate() -> CGFloat {
        let designRate = 667 / self
        let value = UIScreen.height / designRate
        return value
    }
}
