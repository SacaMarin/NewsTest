//
//  UIViewExtension.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import UIKit
import SwifterSwift


extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let bounds =  CGRect(x: frame.origin.x, y: frame.origin.y, width: UIScreen.main.bounds.width, height: frame.height)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadowTo() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}

extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}
