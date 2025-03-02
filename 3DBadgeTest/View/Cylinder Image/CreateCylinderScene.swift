//
//  CreateCylinderScene.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//
import SwiftUI
import SceneKit

func createCylinderScene(imageName: String, height: CGFloat, sideColor: UIColor) -> SCNScene {
    let scene = SCNScene()

    let cylinder = SCNCylinder(radius: 1.0, height: height)

    let topFaceMaterial = SCNMaterial()
    if let image = UIImage(named: imageName)?
        .flippedHorizontally()?
        .rotated(by: -90) {
        topFaceMaterial.diffuse.contents = image
        topFaceMaterial.isDoubleSided = true
    }

    let sideMaterial = SCNMaterial()

    let startColor = sideColor
    let endColor = sideColor.darker()
    let frame = CGRect(x: 0, y: 0, width: 150, height: height * 150)
    sideMaterial.diffuse.contents = startColor.cylindricalGradientLayer(frame: frame, startColor: startColor, endColor: endColor)


    cylinder.materials = [sideMaterial, topFaceMaterial, topFaceMaterial]

    let cylinderNode = SCNNode(geometry: cylinder)
    cylinderNode.rotation = SCNVector4(1, 0, 0, Float.pi / 2)
    scene.rootNode.addChildNode(cylinderNode)

    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(0, 0, 5)
    scene.rootNode.addChildNode(cameraNode)

    return scene
}


#Preview {
    ContentView()
}
