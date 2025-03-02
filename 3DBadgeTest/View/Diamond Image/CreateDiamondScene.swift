//
//  Untitled.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SwiftUI
import SceneKit


func createDiamondScene(imageName: String?, height: CGFloat, width: CGFloat, depth: CGFloat, sideColor: UIColor) -> SCNScene {
    let scene = SCNScene()

    let extrusionSettings = SCNGeometry.ExtrusionSettings(depth: depth, chamferRadius: 0)
    let prismGeometry = SCNGeometry.diamondPrism(height: height, width: width, extrusionSettings: extrusionSettings)

    let frontMaterial = SCNMaterial()
    if let imageName = imageName, let image = UIImage(named: imageName) {
        frontMaterial.diffuse.contents = image
        frontMaterial.isDoubleSided = true
        frontMaterial.lightingModel = .constant
    } else {
        frontMaterial.diffuse.contents = UIColor.black
    }

    let sideMaterials = (0..<4).map { _ in SCNMaterial() } // 4 sides for a diamond prism

    let startColor = sideColor
    let endColor = sideColor.darker()

    let frame = CGRect(x: 0, y: 0, width: 150, height: height * 150)

    for i in 0..<4 {
        sideMaterials[i].diffuse.contents = startColor.gradientLayer(with: [startColor, endColor], frame: frame)
        sideMaterials[i].lightingModel = .constant
        sideMaterials[i].isDoubleSided = false
    }

    prismGeometry.materials = [
        frontMaterial,
        frontMaterial,
        sideMaterials[0],
        sideMaterials[1],
        sideMaterials[2],
        sideMaterials[3]
    ]

    let prismNode = SCNNode(geometry: prismGeometry)
    scene.rootNode.addChildNode(prismNode)

    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(0, 0, 5)
    scene.rootNode.addChildNode(cameraNode)

    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light?.type = .omni
    lightNode.position = SCNVector3(0, 5, 5)
    scene.rootNode.addChildNode(lightNode)

    return scene
}

#Preview {
    ContentView()
}
