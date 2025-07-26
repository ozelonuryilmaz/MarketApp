//
//  UIView+Extensions.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

extension UIView {
    
    func bounceAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.075, 0.975, 1.0]
        bounceAnimation.duration = 0.3
        bounceAnimation.calculationMode = .cubic
        layer.add(bounceAnimation, forKey: "m_bounce")
    }
    
    func animatedAlpha(from: CGFloat, to: CGFloat, withDuration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            self.alpha = from
            UIView.animate(withDuration: withDuration, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = to
            }, completion: nil)
        }
    }
}
