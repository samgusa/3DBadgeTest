//
//  BadgeShape.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/15/25.
//

import Foundation
import SwiftUI

enum ShapeType: String, CaseIterable {
    case cylinder = "Cylinder"
    case cube = "Cube"
    case triangularPrism = "Triangular Prism"
    case diamondPrism = "Diamond Prism"
}

struct BadgeShape {
    let type: ShapeType
    let size: CGFloat
    let height: CGFloat
    let imageName: String
}
