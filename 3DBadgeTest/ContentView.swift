//
//  ContentView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    var shapeType: ShapeType
    var body: some View {
        BadgeEditorView(shapeType: shapeType)
    }
}

#Preview {
    ContentView(shapeType: .cylinder)
}
