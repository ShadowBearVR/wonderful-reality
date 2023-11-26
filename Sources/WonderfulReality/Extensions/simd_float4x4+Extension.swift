//
//  simd_float4x4.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import simd

extension simd_float4x4 {
    public var position: SIMD3<Float> {
        return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
    }
    
    public var worldFront: SIMD3<Float> {
        return -normalize(SIMD3<Float>(columns.2.x, columns.2.y, columns.2.z))
    }
    
    public var worldUp: SIMD3<Float> {
        return normalize(SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z))
    }
    
    public var worldRight: SIMD3<Float> {
        return normalize(SIMD3<Float>(columns.0.x, columns.0.y, columns.0.z))
    }

    public var m11: Float {
        get { return columns.0.x }
        set { columns.0.x = newValue }
    }
    
    public var m12: Float {
        get { return columns.0.y }
        set { columns.0.y = newValue }
    }
    
    public var m13: Float {
        get { return columns.0.z }
        set { columns.0.z = newValue }
    }
    
    public var m14: Float {
        get { return columns.0.w }
        set { columns.0.w = newValue }
    }
    
    public var m21: Float {
        get { return columns.1.x }
        set { columns.1.x = newValue }
    }
    
    public var m22: Float {
        get { return columns.1.y }
        set { columns.1.y = newValue }
    }
    
    public var m23: Float {
        get { return columns.1.z }
        set { columns.1.z = newValue }
    }
    
    public var m24: Float {
        get { return columns.1.w }
        set { columns.1.w = newValue }
    }
    
    public var m31: Float {
        get { return columns.2.x }
        set { columns.2.x = newValue }
    }
    
    public var m32: Float {
        get { return columns.2.y }
        set { columns.2.y = newValue }
    }
    
    public var m33: Float {
        get { return columns.2.z }
        set { columns.2.z = newValue }
    }
    
    public var m34: Float {
        get { return columns.2.w }
        set { columns.2.w = newValue }
    }
    
    public var m41: Float {
        get { return columns.3.x }
        set { columns.3.x = newValue }
    }
    
    public var m42: Float {
        get { return columns.3.y }
        set { columns.3.y = newValue }
    }
    
    public var m43: Float {
        get { return columns.3.z }
        set { columns.3.z = newValue }
    }
    
    public var m44: Float {
        get { return columns.3.w }
        set { columns.3.w = newValue }
    }
}
