//
//  Extension+SCNGeometry.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SceneKit
import SwiftUI

extension SCNGeometry {

    static func createPlane(width: CGFloat, height: CGFloat) -> SCNGeometry {
        let plane = SCNPlane(width: width, height: height)
        return plane
    }

    struct ExtrusionSettings {
        var depth: CGFloat
        var chamferRadius: CGFloat
    }

    static func triangularPrism(height: CGFloat, baseWidth: CGFloat, baseLength: CGFloat, extrusionSettings: ExtrusionSettings) -> SCNGeometry {
        let halfBaseWidth = baseWidth / 2

        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: height / 2))
        trianglePath.addLine(to: CGPoint(x: -halfBaseWidth, y: -height / 2))
        trianglePath.addLine(to: CGPoint(x: halfBaseWidth, y: -height / 2))
        trianglePath.close()

        let prismGeometry = SCNShape(path: trianglePath, extrusionDepth: CGFloat(baseLength))

        return prismGeometry
    }

    static func diamondPrism(height: CGFloat, width: CGFloat, extrusionSettings: ExtrusionSettings) -> SCNGeometry {
        let halfWidth = width / 2
        let halfHeight = height / 2

        // 1. Create 2D diamond (rhombus) shape
        let diamondPath = UIBezierPath()
        diamondPath.move(to: CGPoint(x: 0, y: halfHeight)) // Top point
        diamondPath.addLine(to: CGPoint(x: halfWidth, y: 0)) // Right point
        diamondPath.addLine(to: CGPoint(x: 0, y: -halfHeight)) // Bottom point
        diamondPath.addLine(to: CGPoint(x: -halfWidth, y: 0)) // Left point
        diamondPath.close()

        let prismGeometry = SCNShape(path: diamondPath, extrusionDepth: extrusionSettings.depth)

        return prismGeometry
    }
}

#Preview {
    ContentView()
}
