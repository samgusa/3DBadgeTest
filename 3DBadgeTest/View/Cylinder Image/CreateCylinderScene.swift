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

    // Create a cylinder
    let cylinder = SCNCylinder(radius: 1.0, height: height)

    // Apply materials
    let topFaceMaterial = SCNMaterial()
    if let image = UIImage(named: imageName)?
        .flippedHorizontally()?
        .rotated(by: -90) {
        topFaceMaterial.diffuse.contents = image
        topFaceMaterial.isDoubleSided = true
    }

    let sideMaterial = SCNMaterial()

    let startColor = sideColor // Customize this to match your sideColor
    let endColor = sideColor.darker() // Customize this to match your desired gradient end color
    let frame = CGRect(x: 0, y: 0, width: 150, height: height * 150) // Adjust height to fit your cylinder
    sideMaterial.diffuse.contents = startColor.cylindricalGradientLayer(frame: frame, startColor: startColor, endColor: endColor)


    // Assign materials to geometry faces (top, side, bottom)
    cylinder.materials = [sideMaterial, topFaceMaterial, topFaceMaterial]

    // Create a node with the cylinder
    let cylinderNode = SCNNode(geometry: cylinder)
    cylinderNode.rotation = SCNVector4(1, 0, 0, Float.pi / 2)
    scene.rootNode.addChildNode(cylinderNode)

    // Add a camera
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(0, 0, 5)
    scene.rootNode.addChildNode(cameraNode)

    return scene


}


#Preview {
    ContentView()
}
