//
//  VectorUtils3D.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import simd

struct VectorUtils3D {
    // Derived from: Rodrigues' Rotation Formula
    // Source: https://mathworld.wolfram.com/RodriguesRotationFormula.html
    public static func rotate(vector: SIMD3<Float>, aroundAxis axis: SIMD3<Float>, withAngle angleDegrees: Float) -> SIMD3<Float> {
        let angle = angleDegrees * (Float.pi / 180)
        let normalizedAxis = normalize(axis)
        let cosTheta = cos(angle)
        let sinTheta = sin(angle)

        let crossProduct = cross(normalizedAxis, vector)
        let dotProduct = dot(normalizedAxis, vector)

        return vector * cosTheta + crossProduct * sinTheta + normalizedAxis * dotProduct * (1 - cosTheta)
    }
}
