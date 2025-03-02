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



## Things I figured out: 

I realized that there I would need to create the same setup code many times, for each 3D shape that I wanted to create. This annoyed me, because in the future I would have to create the same code multiple times. I beleive that the best thing to do when programming is to reduce your work to the best of our abilities, hence I thought of making something that can be reusable. 












