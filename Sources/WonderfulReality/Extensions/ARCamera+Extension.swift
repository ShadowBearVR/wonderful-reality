//
//  ARCamera+Extension.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import ARKit

public extension ARCamera {
    var aspectRatio: Float {
        return projectionMatrix.m11 / projectionMatrix.m22
    }
    
    var verticalFieldOfViewRadians: Float {
        let yScale = projectionMatrix.m22
        return 2 * atan(1 / yScale)
    }
    
    var verticalFieldOfViewDegrees: Float {
        return verticalFieldOfViewRadians * (180 / Float.pi)
    }
    
    var horizontalFieldOfViewRadians: Float {
        return 2 * atan(tan(verticalFieldOfViewRadians / 2) * aspectRatio)
    }
    
    var horizontalFieldOfViewDegrees: Float {
        return horizontalFieldOfViewRadians * (180 / Float.pi)
    }
}
