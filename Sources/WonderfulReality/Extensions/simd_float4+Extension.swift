//
//  simd_float4.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import simd

public extension simd_float4 {
    var position: SIMD3<Float> {
        return SIMD3<Float>(self.x, self.y, self.z)
    }
}
