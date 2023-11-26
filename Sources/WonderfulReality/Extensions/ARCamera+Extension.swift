//
//  ARCamera+Extension.swift
//  GaitSentry
//
//  Created by Collin MacDonald on 10/28/23.
//

import ARKit

extension ARCamera {
    var aspectRatio: Float {
        return projectionMatrix.m11 / projectionMatrix.m22
    }
    
    var verticalFieldOfViewRadians: Float {
        let yScale = projectionMatrix.m22
        return 2 * atan(1 / yScale)
    }
    
    var verticalFieldOfViewDegrees: Float {
        return self.verticalFieldOfViewRadians * (180 / Float.pi)
    }
    
    var horizontalFieldOfViewRadians: Float {
        return 2 * atan(tan(verticalFieldOfViewRadians / 2) * aspectRatio)
    }
    
    var horizontalFieldOfViewDegrees: Float {
        return self.horizontalFieldOfViewRadians * (180 / Float.pi)
    }
}
