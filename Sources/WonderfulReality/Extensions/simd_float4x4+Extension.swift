//
//  simd_float4x4.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import simd

public extension simd_float4x4 {
    // MARK: Position
    
    var position: SIMD3<Float> {
        return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
    }
    
    // MARK: Rotation
    
    // Reference: https://stackoverflow.com/questions/50236214/
    
    var eulerAnglesRadians: SIMD3<Float> {
        let pitch = asin(-self[2][1])
        let yaw = atan2(self[2][0], self[2][2])
        let roll = atan2(self[0][1], self[1][1])
        
        return SIMD3<Float>(pitch, yaw, roll)
    }
    
    var eulerAnglesDegrees: SIMD3<Float> {
        let rad2deg = (180 / Float.pi)
        return eulerAnglesRadians * rad2deg
    }

    
    // MARK: Direction Vectors
    
    var backwardVector: SIMD3<Float> {
        return simd_normalize(SIMD3<Float>(columns.2.x, columns.2.y, columns.2.z))
    }
    
    var forwardVector: SIMD3<Float> {
        return -backwardVector
    }
    
    var upVector: SIMD3<Float> {
        return simd_normalize(SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z))
    }
    
    var downVector: SIMD3<Float> {
        return -upVector
    }
    
    var rightVector: SIMD3<Float> {
        return simd_normalize(SIMD3<Float>(columns.0.x, columns.0.y, columns.0.z))
    }
    
    var leftVector: SIMD3<Float> {
        return -rightVector
    }
    
    // MARK: Matrix Values

    var m11: Float {
        get { return columns.0.x }
        set { columns.0.x = newValue }
    }
    
    var m12: Float {
        get { return columns.0.y }
        set { columns.0.y = newValue }
    }
    
    var m13: Float {
        get { return columns.0.z }
        set { columns.0.z = newValue }
    }
    
    var m14: Float {
        get { return columns.0.w }
        set { columns.0.w = newValue }
    }
    
    var m21: Float {
        get { return columns.1.x }
        set { columns.1.x = newValue }
    }
    
    var m22: Float {
        get { return columns.1.y }
        set { columns.1.y = newValue }
    }
    
    var m23: Float {
        get { return columns.1.z }
        set { columns.1.z = newValue }
    }
    
    var m24: Float {
        get { return columns.1.w }
        set { columns.1.w = newValue }
    }
    
    var m31: Float {
        get { return columns.2.x }
        set { columns.2.x = newValue }
    }
    
    var m32: Float {
        get { return columns.2.y }
        set { columns.2.y = newValue }
    }
    
    var m33: Float {
        get { return columns.2.z }
        set { columns.2.z = newValue }
    }
    
    var m34: Float {
        get { return columns.2.w }
        set { columns.2.w = newValue }
    }
    
    var m41: Float {
        get { return columns.3.x }
        set { columns.3.x = newValue }
    }
    
    var m42: Float {
        get { return columns.3.y }
        set { columns.3.y = newValue }
    }
    
    var m43: Float {
        get { return columns.3.z }
        set { columns.3.z = newValue }
    }
    
    var m44: Float {
        get { return columns.3.w }
        set { columns.3.w = newValue }
    }
}
