//
//  CreateTriangleScene.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SceneKit
import UIKit
import SwiftUI


func createTriangleScene(imageName: String?, height: CGFloat, baseWidth: CGFloat, baseLength: CGFloat, sideColor: UIColor) -> SCNScene {
    let scene = SCNScene()

    let extrusionSettings = SCNGeometry.ExtrusionSettings(depth: baseLength, chamferRadius: 0)
    let prismGeometry = SCNGeometry.triangularPrism(height: height, baseWidth: baseWidth, baseLength: baseLength, extrusionSettings: extrusionSettings)

    let frontMaterial = SCNMaterial()
    if let imageName = imageName, let image = UIImage(named: imageName) {
        frontMaterial.diffuse.contents = image
        frontMaterial.isDoubleSided = true
        frontMaterial.lightingModel = .constant
    } else {
        frontMaterial.diffuse.contents = UIColor.black
    }

    let sideMaterial = SCNMaterial()

    let startColor = sideColor
    let endColor = sideColor.darker()

    let frame = CGRect(x: 0, y: 0, width: 150, height: height * 150)

    sideMaterial.diffuse.contents = startColor.gradientLayer(with: [startColor, endColor], frame: frame)
    sideMaterial.lightingModel = .constant
    sideMaterial.isDoubleSided = false

    prismGeometry.materials = [
        frontMaterial,
        frontMaterial,
        sideMaterial
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
    ContentView(shapeType: .triangularPrism)
}
