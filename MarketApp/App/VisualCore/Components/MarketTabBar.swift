//
//  MarketTabBar.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

@IBDesignable
public final class MarketTabBar: UITabBar {

    // MARK:- Variables -
    @objc public var centerButtonActionHandler: () -> () = { }

    @IBInspectable public var tabbarColor: UIColor = .white
    @IBInspectable public var selectedItemColor: UIColor = .white
    @IBInspectable public var unselectedItemColor: UIColor = .white

    private var shapeLayer: CALayer?

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = tabbarColor.cgColor
        shapeLayer.lineWidth = 0

        // shadow
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0.5)
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.25

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        self.tintColor = selectedItemColor
        self.unselectedItemTintColor = unselectedItemColor
    }
    
    private func createPath() -> CGPath {
        let height: CGFloat = CGFloat(22).adjustWidthRespectToDesignRate()
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - (height * 1.1)), y: 0))

        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }

    override public func draw(_ rect: CGRect) {
        self.addShape()
    }

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

extension MarketTabBar {

    func makeDefaultAppStyle() {
        tabbarColor = .white
        selectedItemColor = .gray
        unselectedItemColor = .lightGray
    }
}
