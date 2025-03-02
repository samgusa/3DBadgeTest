//
//  CreateCubeScene.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SceneKit

func createCubeScene(imageName: String, size: CGFloat, sideLength: CGFloat, sideColor: UIColor, sideImages: [String]) -> SCNScene {
    let scene = SCNScene()

    let cube = SCNBox(width: size, height: size, length: sideLength, chamferRadius: 0)

    let frontMaterial = SCNMaterial()
    frontMaterial.diffuse.contents = UIImage(named: imageName)
    frontMaterial.lightingModel = .constant

    let sideMaterials = (0..<4).map { _ in SCNMaterial() }

    let startColor = sideColor
    let endColor = sideColor.darker()
    let frame = CGRect(x: 0, y: 0, width: 150, height: size * 150)

    for i in 0..<4 {
        if i < sideImages.count && !sideImages[i].isEmpty {
            sideMaterials[i].diffuse.contents = UIImage(named: sideImages[i])
        } else {
            sideMaterials[i].diffuse.contents = startColor.gradientLayer(with: [startColor, endColor], frame: frame)
        }
        sideMaterials[i].lightingModel = .constant
    }

    cube.materials = [
        frontMaterial,
        sideMaterials[0],
        frontMaterial,
        sideMaterials[1],
        sideMaterials[2],
        sideMaterials[3]
    ]

    let cubeNode = SCNNode(geometry: cube)
    scene.rootNode.addChildNode(cubeNode)

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
