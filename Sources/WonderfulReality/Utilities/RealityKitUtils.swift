//
//  RealityKitUtils.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import ARKit
import RealityKit
import UIKit

public enum RealityKitUtils {
    public static func computeCollisionPoints(cameraTransform: simd_float4x4, view: ARView, camera: ARCamera, fovStep: Float) -> [SIMD3<Float>] {
        // Get relevant transform data
        let cameraPosition = cameraTransform.position
        let forwardVector = cameraTransform.forwardVector
        let upVector = cameraTransform.upVector
        
        // Get field of view data
        let hFOV = camera.horizontalFieldOfViewDegrees
        let halfFOV = (hFOV / 2).rounded(.towardZero)
        let minFOV = -halfFOV
        let maxFOV = halfFOV
        
        var points3D = [SIMD3<Float>]()
        
        for currentAngle in stride(from: minFOV, through: maxFOV, by: fovStep) {
            let rayDirection = Vector3DUtils.rotate(vector: forwardVector, aroundAxis: upVector, withAngle: Float(currentAngle))
            
            let raycastResults = view.scene.raycast(origin: cameraPosition, direction: rayDirection)
            
            if let firstResult = raycastResults.first {
                let resultPosition = firstResult.position
                
                points3D.append(resultPosition)
            }
        }
        
        return points3D
    }
    
    public static func visualizeLine(from start: SIMD3<Float>, to end: SIMD3<Float>, lineThickness: Float, lineColor: UIColor) -> ModelEntity {
        // Calculate the mid-point, distance, and orientation between points
        let midPoint = (start + end) / 2
        let distance = simd_distance(start, end)
        let direction = simd_normalize(end - start)
        
        // Create a thin box (as a line segment) model entity
        let boxMesh = MeshResource.generateBox(size: [lineThickness, lineThickness, distance])
        let material = SimpleMaterial(color: lineColor, isMetallic: false)
        let boxEntity = ModelEntity(mesh: boxMesh, materials: [material])
        
        // Position and orient the box
        boxEntity.position = simd_make_float3(midPoint)
        boxEntity.orientation = simd_quatf(from: [0, 0, 1], to: direction)
        
        return boxEntity
    }
    
    public static func visualizePoints(fromPoints points3D: [SIMD3<Float>], lineThickness: Float, lineColor: UIColor, pointsToIgnore: Int = 0) -> AnchorEntity? {
        guard points3D.count >= 3 else {
            return nil
        }
        
        let lineAnchor = AnchorEntity()
        
        for i in pointsToIgnore ..< points3D.count - 1 {
            let start = points3D[i]
            let end = points3D[i + 1]
            
            let boxEntity = visualizeLine(from: start,
                                          to: end,
                                          lineThickness: lineThickness,
                                          lineColor: lineColor)
            
            // Add the box entity to the anchor
            lineAnchor.addChild(boxEntity)
        }
        
        return lineAnchor
    }
}
