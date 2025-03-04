//
//  CubeImageView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SwiftUI

struct CubeImageView: View {
    let imageName: String
    let height: CGFloat = 2.0
    let sideColor: Color = .blue
    let sideImg1: String = "Test1"
    let sideImg2: String = "Test2"
    let sideImg3: String = "img1"
    let sideImg4: String = "img2"

    var body: some View {
        SCNViewRepresentable(
            scene: createCubeScene(
                imageName: imageName,
                size: height,
                sideLength: height,
                sideColor: UIColor(sideColor),
                sideImages: ["", sideImg2, sideImg3, sideImg4]))

    }
}

#Preview {
    ContentView(shapeType: .cube)
}
