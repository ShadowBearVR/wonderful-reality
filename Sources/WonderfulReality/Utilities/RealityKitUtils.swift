//
//  RealityKitUtils.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import RealityKit
import UIKit

public enum RealityKitUtils {
    public static func visualizePoints(fromPoints points3D: [SIMD3<Float>], lineThickness: Float, lineColor: UIColor, pointsToIgnore: Int = 0) -> AnchorEntity? {
        guard points3D.count >= 3 else {
            return nil
        }
        
        let lineAnchor = AnchorEntity()
        
        for i in pointsToIgnore ..< points3D.count - 1 {
            let start = points3D[i]
            let end = points3D[i + 1]
            
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
            
            // Add the box entity to the anchor
            lineAnchor.addChild(boxEntity)
        }
        
        return lineAnchor
    }
}
