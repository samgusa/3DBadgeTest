//
//  BadgeEditorView.swift
//  3DBadgeTest
//
//  Created by Sam Greenhill on 2/15/25.
//

import SwiftUI

struct BadgeEditorView: View {
    @StateObject private var viewModel = BadgeViewModel(initialShape: .cylinder)
    @State var shapeType: ShapeType
    
    var body: some View {
        VStack {
            Text("Choose a 3D Shape")
                .font(.title2)
                .padding(.top)
            
            ZStack {
                switch shapeType {
                case .cylinder:
                    CylinderImageView(imageName: viewModel.selectedShape.imageName)
                        .frame(width: 300, height: 300)
                case .cube:
                    CubeImageView(imageName: viewModel.selectedShape.imageName)
                        .frame(width: 300, height: 300)
                case .triangularPrism:
                    TriangularPrismImageView(imageName: viewModel.selectedShape.imageName)
                        .frame(width: 300, height: 300)
                case .diamondPrism:
                    DiamondPrismImageView(imageName: viewModel.selectedShape.imageName)
                        .frame(width: 300, height: 300)
                }
            }
            .background(Color.gray.gradient.opacity(0.8))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(ShapeType.allCases, id: \.self) { shape in
                        Button(action: {
                            shapeType = shape
                            viewModel.updateShape(type: shape)
                        }) {
                            VStack {
                                Image(systemName: shapeIcon(for: shape))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Circle().fill(viewModel.selectedShape.type == shape ? Color.blue.opacity(0.3) : Color.clear))
                                
                                Text(shape.rawValue)
                                    .font(.caption)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.updateShape(type: shapeType) // Update onAppear to reflect initial shape
        }
        
    }
    
    func shapeIcon(for shape: ShapeType) -> String {
        switch shape {
        case .cylinder: return "circle"
        case .cube: return "square"
        case .triangularPrism: return "triangle"
        case .diamondPrism: return "diamond"
        }
    }
}

#Preview {
    ContentView(shapeType: .cylinder)
}
