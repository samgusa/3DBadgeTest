# 3DBadgeTest

This is a fun project that I am working on. I recently passed my CompTIA Security + certification, and I want to show my certification on my phone. I am going to do this by creating a 3D shape of my certification, in different shapes. 

I think that I am going to try other ways to improve this as well. 

## 3D Shapes:

<p float="left">
  <img src="https://github.com/user-attachments/assets/1a97f234-fb8c-45b6-bc1e-7e21fa675d43" alt="" width="200" height="450">
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/182afa63-5d9b-435b-85f6-a731af004f3b" alt="" width="200" height="450"> 
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/7ec604a3-eb56-4617-983c-6a4beb04b483" alt="" width="200" height="450">
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/11fffb25-4324-415f-9607-bfcebb2dad5e" alt="" width="200" height="450">
</p>




## Data about SceneKit and SCN: 

SceneKit is the Xcode native framework that can be used to create 3D shapes. SceneKit has 9 base shapes that can be used. They are: SCNPlane, SCNBox, SCNSphere, SCNPyramid, SCNCone, SCNCylinder, SCNCapsule, SCNTube, and SCNTorus.

Here is more data on that: https://developer.apple.com/documentation/scenekit/scngeometry

While these are the built in shapes, there are ways to create your own custom 3D shape. Using this [link](https://www.hackingwithswift.com/books/ios-swiftui/creating-custom-paths-with-swiftui) to a hackingwithswift page, I found a way to try and create my own shapes, which in my case is the triangular prism and diamond prism. **The only issue is that this article is for SwiftUI, but it is simple to make it into UIKit which is the only way to create a 3D shape.** Reading it, I found that the secret to creating a 3D shape is that you will need to draw it yourself.

You start of with a move, include an addLine, and remember (absolutely remember) to close it off. The UIBezierPath is a UIKit class used to create vector-based paths. This is used to begin the creation of a shape. 

For example, this is what a triangle would look like using Path:

```swift
let trianglePath = UIBezierPath()
trianglePath.move(to: CGPoint(x: 200, y: 100))
trianglePath.addLine(to: CGPoint(x: 100, y: 300))
trianglePath.addLine(to: CGPoint(x: 300, y: 300))
trianglePath.addLine(to: CGPoint(x: 200, y: 100))
trianglePath.close()

```



What this means simply is:

<img align="right" width="60" height="100"  alt="Shape01" src="https://github.com/user-attachments/assets/aeb68ff3-3441-45a7-9783-6a70ad816d27" />

1. Start at the point (200, 100).
2. Draws a line to (100, 300).
3. Draws a line to (300, 300).
4. Draws a line back to (200, 100), closing the shape.

<img align="right" width="60" height="100" alt="Shape02" src="https://github.com/user-attachments/assets/f2cbf6ed-87fd-41ae-b4d4-a387c9bfca26" />

Editing any of these values in the CGPoint changes the shape. For example, changing the second(2nd) .addLine to path.addLine(to: CGPoint(x: 300, y: 300)) to path.addLine(to: CGPoint(x: **200**, y: 300)) Turns the triangle from an Equilateral triangle to a Right triangle: 



The only thing left to do is turn this 2D shape into a 3D shape. Thankfully there is a way to do it in UIKit, and it is the simple (but powerful) SCNShape. 
SCNShape takes the path, which is the shape that we made, and the extrusionDepth, which is the side length to make it 3 Dimensional. 

```swift
let prismGeometry = SCNShape(path: trianglePath, extrusionDepth: CGFloat(baseLength))
```

Now you have a 3D shape. 

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

Now you have a UIKit method to create a gradient. 

## Image on Shape's Face

Now that we have a 3D shape, we need to figure out how to get the image on the face. This may be slightly different for each shape, but it uses the same principle for each of them. 

The term XCode uses to refer to the faces and sides of 3D shapes is Material. SCNMaterial is the method used to create the different faces and sides of a 3D shape. 
This part is easy, as it is just creating an instance of SCNMaterial, then defining what is in it. Then we can make it an image. 

diffuse.contents is what the face of the shape will be, and then setting it as double sided makes the image appear of both sides of the circle. 


This is the code: 

<img align="right" img width="110" height="200" alt="Shape03" src="https://github.com/user-attachments/assets/0868c991-e5ec-427a-ad09-9cf7cadc49af" />

```swift
let topFaceMaterial = SCNMaterial()
if let image = UIImage(named: imageName)? {
        topFaceMaterial.diffuse.contents = image
        topFaceMaterial.isDoubleSided = true
    }
```

There is one issue that I found with this, and that is that the image usually appears backwards and slightly tilted, and backwards. 

I believe that it is just the way that XCode does this, so it is something that will need a little more work to fix. 

We will need to flip the image horizontally, then rotate the image. These two functions do all that. 

```swift
extension UIImage {
    func flippedHorizontally() -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.translateBy(x: size.width, y: 0)
        context.scaleBy(x: -1, y: 1)

        draw(at: CGPoint.zero)

        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return flippedImage
    }

    func rotated(by degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / -180
        lazy var newSize = CGRect(origin: CGPoint.zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .integral.size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContext(newSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return rotatedImage
    }
}
```

We then can use them to fix the image. 

<img align="right" width="110" height="200" alt="Shape03" src="https://github.com/user-attachments/assets/62f7503b-cb62-45ae-9cd2-1d1941a16e75" />

```swift
let topFaceMaterial = SCNMaterial()
    if let image = UIImage(named: imageName)?
        .flippedHorizontally()?
        .rotated(by: -90) {
        topFaceMaterial.diffuse.contents = image
        topFaceMaterial.isDoubleSided = true
    }
```

It is also important to make a side material, or else there won't be one, and will appear as if there is nothing there. 
We can create the side material the same way as the face material, but this time we will give it a color. 

```swift

let sideMaterial = SCNMaterial()
let color = UIColor.red

sideMaterial.diffuse.contents = color

```

We can now place all of these into our shape. In this case I am using Cylinder which is a native Swift 3D shape, but you can use your own shape of type SCNGeometry. 

```swift

cylinder.materials = [sideMaterial, topFaceMaterial, topFaceMaterial]

```

The order is important, because that will determine where the image goes. For a cylinder, it is side material, then the front face, then the back face. 

### Side Images

Using a similar method to creating the face material, we can add an image to the sides of a shape. While it is possible for other shapes, I found it looks better in a cube, above the others. Because their are 6 faces on a Cube: front, back, left, right, top, bottom, we will need to create a sideMaterial for each side, outside of the main face. 

```swift

let sideMaterial1 = SCNMaterial()
sideMaterial1.diffuse.contents = UIImage(named: sideImage1)
sideMaterial.lightingModel = .constant

cube.materials = [
        frontMaterial,
        sideMaterial1,
        frontMaterial,
        sideMaterial2,
        sideMaterial3,
        sideMaterial4
    ]

```

This is not the best way to make the side materials, It isn't that scalable, and we would have to do the same for each side material we have. 

I found a for loop to be the best way to scale this up, while making it easier to read, and maintain. If I want to add something to one or all of them, it is a simple call and implementation. 

One thing to note, when I designed my shapes, I wanted to check to see if it was given an image, and if not, then it just has a colored side. This is important because if there is nothing on that side then it will show a cube with nothing on that side. 

```swift

let sideMaterials = (0..<4).map { _ in SCNMaterial() }

 for i in 0..<4 {
        if i < sideImages.count && !sideImages[i].isEmpty {
            sideMaterials[i].diffuse.contents = UIImage(named: sideImages[i])
        } else {
            sideMaterials[i].diffuse.contents = startColor.gradientLayer(with: [startColor, endColor], frame: frame)
        }
        sideMaterials[i].lightingModel = .constant
    }
```

This takes all the lines of code to create 4 side images, and condenses it, and makes it easier to read and see. 

Now that we have set up the face and side materials, we just need to add it to the cube. Similar to the cylinder, we set a cube's materials to the materials we created. 

```swift
    let cube = SCNBox(width: size, height: size, length: sideLength, chamferRadius: 0)

cube.materials = [
        frontMaterial,
        sideMaterials[0],
        frontMaterial,
        sideMaterials[1],
        sideMaterials[2],
        sideMaterials[3]
    ]

```

Now, this is important, but the order of the materials in the cube material is important to get right, because that determines what side is which. So I found that this is the order: 

```swift
cube.materials = [
    Front of cube,
    Right side of cube,
    Back of cube (behind the front),
    Top of cube,
    Bottom of cube
]

```

## Things I figured out: 

I realized that in certain areas I would need to create the same setup code many times, for each 3D shape that I wanted to create. This annoyed me, because in the future I would have to write the same code over and over again. I like it when I create good reusable code, so I tried to figure out how to do that for a SCNScene. 

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

## Future Thoughts:

Here are some things that I am thinking of adding to this, that may make it a little more customizable. Here are some of my thoughts. 

- Slider to increase size of sides.
- Color Picker, to choose different color for the sides.
- Let user choose an image from Photos.
- Have an editing mode, where all of these changes can be made
- Animate the Picker

