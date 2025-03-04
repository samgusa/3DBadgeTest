//
//  TriangularPrismImageView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SwiftUI

struct TriangularPrismImageView: View {
    let imageName: String?
    let sideColor: Color = .blue
    let height: CGFloat = 3.0
    let baseWidth: CGFloat = 3.0
    let baseLength: CGFloat = 0.2

    var body: some View {
        SCNViewRepresentable(
            scene: createTriangleScene(
                imageName: imageName,
                height: height,
                baseWidth: baseWidth,
                baseLength: baseLength,
                sideColor: UIColor(sideColor))
        )
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ContentView(shapeType: .triangularPrism)
}
