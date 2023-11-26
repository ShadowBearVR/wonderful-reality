//
//  ARCamera+Extension.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import ARKit

extension ARCamera {
    public var aspectRatio: Float {
        return projectionMatrix.m11 / projectionMatrix.m22
    }
    
    public var verticalFieldOfViewRadians: Float {
        let yScale = projectionMatrix.m22
        return 2 * atan(1 / yScale)
    }
    
    public var verticalFieldOfViewDegrees: Float {
        return self.verticalFieldOfViewRadians * (180 / Float.pi)
    }
    
    public var horizontalFieldOfViewRadians: Float {
        return 2 * atan(tan(verticalFieldOfViewRadians / 2) * aspectRatio)
    }
    
    public var horizontalFieldOfViewDegrees: Float {
        return self.horizontalFieldOfViewRadians * (180 / Float.pi)
    }
}
