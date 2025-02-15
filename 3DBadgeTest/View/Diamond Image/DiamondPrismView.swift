//
//  DiamondPrismView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SwiftUI

struct DiamondPrismImageView: View {
    let imageName: String?
    let sideColor: Color = .blue
    let height: CGFloat = 3.0
    let width: CGFloat = 3.0
    let depth: CGFloat = 0.2

    var body: some View {
        SCNViewRepresentable(
            scene: createDiamondScene(
                imageName: imageName,
                height: height,
                width: width,
                depth: depth,
                sideColor: UIColor(sideColor))
        )
        .frame(width: 200, height: 200) // Adjust size as needed
    }
}

#Preview {
    ContentView()
}
