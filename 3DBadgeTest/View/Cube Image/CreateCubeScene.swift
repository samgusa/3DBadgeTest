//
//  CreateCubeScene.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SceneKit

func createCubeScene(imageName: String, size: CGFloat, sideLength: CGFloat, sideColor: UIColor, sideImages: [String]) -> SCNScene {
    let scene = SCNScene()

    // Cube geometry
    let cube = SCNBox(width: size, height: size, length: sideLength, chamferRadius: 0)

    // Materials for the cube
    let frontMaterial = SCNMaterial()
    frontMaterial.diffuse.contents = UIImage(named: imageName) // Display the image on the front face
    frontMaterial.lightingModel = .constant

    let sideMaterials = (0..<4).map { _ in SCNMaterial() }

    let startColor = sideColor // Customize this to match your sideColor
    let endColor = sideColor.darker() // Customize this to match your desired gradient end color
    let frame = CGRect(x: 0, y: 0, width: 150, height: size * 150) // Adjust height to fit your cylinder

    for i in 0..<4 {
        if i < sideImages.count && !sideImages[i].isEmpty { // Check if imagename exists
            sideMaterials[i].diffuse.contents = UIImage(named: sideImages[i])
        } else {
            sideMaterials[i].diffuse.contents = startColor.gradientLayer(with: [startColor, endColor], frame: frame)
        }
        sideMaterials[i].lightingModel = .constant
    }

    cube.materials = [
        frontMaterial,
        sideMaterials[0], // Right - top
        frontMaterial,
        sideMaterials[1], // left
        sideMaterials[2], // ??
        sideMaterials[3]
    ]

    // Cube node
    let cubeNode = SCNNode(geometry: cube)
    scene.rootNode.addChildNode(cubeNode)

    // Camera
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(0, 0, 5)
    scene.rootNode.addChildNode(cameraNode)

    // Light
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light?.type = .omni
    lightNode.position = SCNVector3(0, 5, 5)
    scene.rootNode.addChildNode(lightNode)

    return scene
}
