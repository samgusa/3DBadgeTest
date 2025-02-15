//
//  CylinderImageView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/15/25.
//

import SwiftUI
import UIKit

struct CylinderImageView: View {
    let imageName: String
    let height: CGFloat = 0.2
    let sideColor: Color = .blue

    var body: some View {
        SCNViewRepresentable(
            scene:
                createCylinderScene(
                    imageName: imageName,
                    height: height,
                    sideColor: UIColor(sideColor)
                ))
    }

}

#Preview {
    ContentView()
}



