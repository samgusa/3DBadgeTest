# 3DBadgeTest

This is a fun project that I am working on. I recently passed my CompTIA Security + certification, and I want to show my certification on my phone. I am going to do this by creating a 3D shape of my certification, in different shapes. 

I think that I am going to try other ways to improve this as well. 

## 3D Shapes:

<p float="left">
  <img src="https://github.com/user-attachments/assets/24ff6c86-0166-44e8-8620-3c6905e71f85" alt="" width="200" height="450">
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/1d62b3d1-5d61-4d50-aba5-7fe857b9fe2d" alt="" width="200" height="450"> 
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/8ce9845b-db1c-44d0-8c3a-78b5b2f25efd" alt="" width="200" height="450">
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/9aebe6eb-b1be-4c13-8634-48bc9b9a243f" alt="" width="200" height="450">
</p>

## Data about SceneKit and SCN: 

SceneKit is the Xcode native framework that can be used to create 3D shapes. SceneKit has 9 base shapes that can be used. They are: SCNPlane, SCNBox, SCNSphere, SCNPyramid, SCNCone, SCNCylinder, SCNCapsule, SCNTube, and SCNTorus.

Here is more data on that: https://developer.apple.com/documentation/scenekit/scngeometry

While these are the built in shapes, there are ways to create your own custom 3D shape. Using this [link](https://github.com/aheze/CustomSCNGeometry) to a github page, I found a way to try and create my own 3D shapes, which in my case is the triangular prism and diamond prism. Reading it, I found that the secret to creating a 3D shape is the vertices.

Vertices are the corner points of a 3D shape. They define the structure of the shape by specifying where the edges and faces connect. As an example, a cube has 8 vertices, while a pyramid has 5 vertices. Each vertex is defined by its position in 3D space using (x, y, z) coordinates, and is represented with SCNVector3. 

```swift
SCNVector3(0, 1, 0)
// this represents a point at x = 0, y = 1, and z = 0
```

Vertices connect to form a edges(lines) and faces(flat surfaces). A face is a flat surface made up of connected vertices. With these put together, we can create a 3D shape. 


## Gradient Sides: 

Making the sides a gradient color was a task in and of itself. Because SceneKit and SwiftUI use different rendering systems, Scenekit doesn't natively understand SwiftUI's Color or gradient. Scenekit is built using UIKit, so there needs to be some confuguring to make it usable in SwiftUI views. In this case it is UIViewRepresentable. 

This is an old equation that I have used before to create a gradient in UIKit, and it worked here as well. 

```swift
func gradientLayer(with colors: [UIColor], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 0, y: 1), frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = frame
        return gradientLayer
    }
```

However, I did not like how this gradient looked in a 3D cylinder shape. The gradient is vertical, so it will go from top to bottom. This doesn't work well for something that looks like it is in a coin shape. I needed to figure somethign out, and that is where location came to play. I was able to use it to change the direction of the gradient to horizontally. 

```swift
func cylindricalGradientLayer(frame: CGRect, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor, startColor.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
```

### Gradient Color:

For someone who is color challenged such as myself, it took me a while to figure out how to find the right colors to make a good gradient. I found out that the best colors are different shades of the same base color, so like blue and slightly darker blue. I feel that makes the best equivalent to SwiftUI's native Color gradient.

Here comes the issue, how do I get the different shades of the color. It is different because there is no native way to change the shade of a color. [Here](https://www.advancedswift.com/lighter-and-darker-uicolor-swift/) is where I found the solution. It creates an extension where I can darken a UIColor and, what is also provided here, lighten a color. 

```swift
extension UIColor {
    private func makeColor(componentDelta: CGFloat) -> UIColor {
        lazy var red: CGFloat = 0
        lazy var blue: CGFloat = 0
        lazy var green: CGFloat = 0
        lazy var alpha: CGFloat = 0

        getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )

        return UIColor(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue),
            alpha: alpha
        )
    }

    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }

    func darker(componentDelta: CGFloat = 0.1) -> UIColor {
        return makeColor(componentDelta: -1 * componentDelta)
    }
}

```

This code adjusts the RGB components of a UIColor. 


## Things I figured out: 

I realized that there I would need to create the same setup code many times, for each 3D shape that I wanted to create. This annoyed me, because in the future I would have to write the same code over and over again. I like it when I create good reusable code, so I tried to figure out how to do that for a SCNScene. 

I had to start to figure out the parts that I can reuse, that was not specific to an individual shape. The reusable parts where: 

- Creating the scene
- Allowing camera control
- Setting the background color -> in my case, .clear. 

```swift
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
```

All that is left is creating a function that returns a SCNScene for each shape. These functions have parameters for each component that I would want for each shape, each sharing an image for the face, and a side color. 

This is the function I used for the Cube shape: 

```swift
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
```

This function is where the individual 3D shape is created, and where I configured where the image will appear on the face, as well as any color I want the sides to have. 

Because it is a cube shape, I decided that I wanted to let the user to choose an image for the sides, which is why I created the sideMaterials in the function. In the first draft, I used an if-else statement for each side. This looked horrible, so I wanted to make it more clean looking as well as take up fewer lines of code. I found a For loop to be the best solution. 




