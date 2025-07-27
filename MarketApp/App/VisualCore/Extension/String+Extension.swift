//
//  String+Extension.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Foundation

extension String {
    
    // TODO: Decimal separators vary by locale:
    // - "tr_TR" uses ',' (e.g. "12,45")
    // - "en_US" uses '.' (e.g. "12.45")
    // Parsing must respect locale to correctly convert string to number.
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "." // Binlik ayırıcı
        formatter.decimalSeparator = ","  // Küsurat ayırıcı
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "tr_TR")
        
        guard let value = Double(self.replacingOccurrences(of: ",", with: ".")) else {
            return self
        }
        
        return formatter.string(from: NSNumber(value: value)) ?? self
    }
}

