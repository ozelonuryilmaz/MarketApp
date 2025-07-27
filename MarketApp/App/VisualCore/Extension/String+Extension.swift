//
//  String+Extension.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

extension String {
    
    // TODO: Decimal separators vary by locale:
    // - "tr_TR" uses ',' (e.g. "12,45")
    // - "en_US" uses '.' (e.g. "12.45")
    // Parsing must respect locale to correctly convert string to number.
    var formattedPrice: String {
        guard let value = Double(self) else { return self }
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.2f", value)
        }
    }
}

