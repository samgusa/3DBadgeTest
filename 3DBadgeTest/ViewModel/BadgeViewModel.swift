//
//  BadgeViewModel.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/15/25.
//

import SwiftUI

class BadgeViewModel: ObservableObject {
    @Published var selectedShape: BadgeShape

    init(initialShape: ShapeType) {
        self.selectedShape = BadgeShape(type: initialShape, size: 2.0, height: 0.3, imageName: "Icon")
    }

    func updateShape(type: ShapeType) {
         self.selectedShape = BadgeShape(type: type, size: 2.0, height: 0.3, imageName: "Icon")
     }
}
