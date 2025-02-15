//
//  SCNViewRepresentable.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/28/25.
//

import SwiftUI
import SceneKit

struct SCNViewRepresentable: UIViewRepresentable {
    let scene: SCNScene

    func makeUIView(context: Context) -> some UIView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .clear
        return sceneView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
