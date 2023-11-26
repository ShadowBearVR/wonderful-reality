# WonderfulReality
## A Swift Utility Package for those working with ARKit, RealityKit, and SIMD Vectors
### Developed by Collin MacDonald

WonderfulReality is a collection of utility classes and extensions that make working in Augmented Reality a bit more... wonderful.

This package was developed based on the needs of a RealityKit-based app I am developing as part of my PhD Coursework at William & Mary.

## Extensions

* [ARCamera+Extension](Sources/WonderfulReality/Extensions/ARCamera+Extension.swift)
  * Extends the `ARCamera` class with computed variables relating to the aspect ratio and field of view for a `ARCamera`.
 
* [simd_float4+Extension](Sources/WonderfulReality/Extensions/simd_float4+Extension.swift)
  * Extends the `simd_float4` class with a computed property for the position (X, Y, and Z components) of any `simd_float4` vector.
 
* [simd_float4x4+Extension](Sources/WonderfulReality/Extensions/simd_float4x4+Extension.swift)
  * Extends the `simd_float4x4` class with computed property that exist in SceneKit but not RealityKit (including position, directional vectors, and `m11` through `m44` variables, for accessing mspecific matrix values).

## Utility Classes

* [ARCameraUtils](Sources/WonderfulReality/Utilities/ARCameraUtils.swift)
  * Contains methods relating to the View Frustrum of a camera in `ARKit`.
 
* [RealityKitUtils](Sources/WonderfulReality/Utilities/RealityKitUtils.swift)
  * Contains a method to visualize an arbitrary set of 3D points in RealityKit.
 
* [Vector2DUtils](Sources/WonderfulReality/Utilities/Vector2DUtils.swift)
  * Contains methods relating to manipulating `SIMD2<Float>` vectors as well as projecting `SIMD3<Float>` vectors into a 2-dimensional space.
  * Also contains methods to determine the width and height of a shape (defined by a series of clockwise points).
 
* [Vector3DUtils](Sources/WonderfulReality/Utilities/Vector3DUtils.swift)
  * Contains a method to rotate a `SIMD3<Float>` vector around an arbitrary axis by a given angle. Based on the Rodrigues' Rotation Formula.
