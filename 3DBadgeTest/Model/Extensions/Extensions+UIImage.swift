//
//  Extensions+UIImage.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import Foundation
import UIKit

extension UIImage {
    func flippedHorizontally() -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        // Move the context to the right and flip it horizontally
        context.translateBy(x: size.width, y: 0)
        context.scaleBy(x: -1, y: 1)

        // Draw the image in the context
        draw(at: CGPoint.zero)

        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return flippedImage
    }

    func rotated(by degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / -180
        lazy var newSize = CGRect(origin: CGPoint.zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .integral.size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContext(newSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        // Move origin to the middle
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        // Rotate around the middle
        context.rotate(by: radians)
        // Draw the image at the origin point
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return rotatedImage
    }
}


