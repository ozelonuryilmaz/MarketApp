//
//  DispatchQueue+Extensions.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation

extension DispatchQueue {

    static func delay(_ milliseconds: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds), execute: closure)
    }
}
