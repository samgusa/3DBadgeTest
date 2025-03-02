//
//  Extensions+Color.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//


import Foundation
import UIKit

extension UIColor {
    private func makeColor(componentDelta: CGFloat) -> UIColor {
        lazy var red: CGFloat = 0
        lazy var blue: CGFloat = 0
        lazy var green: CGFloat = 0
        lazy var alpha: CGFloat = 0

        getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )

        return UIColor(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue),
            alpha: alpha
        )
    }

    // Add value to component ensuring the result is between 0 and 1
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }

    func darker(componentDelta: CGFloat = 0.1) -> UIColor {
        return makeColor(componentDelta: -1 * componentDelta)
    }


    // Method to create a gradient layer from a UIColor
    func gradientLayer(with colors: [UIColor], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 0, y: 1), frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = frame
        return gradientLayer
    }

    // Method to create a gradient layer from a UIColor for cylinder
    func cylindricalGradientLayer(frame: CGRect, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor, startColor.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0] // Centralize the light part of the gradient
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
}
