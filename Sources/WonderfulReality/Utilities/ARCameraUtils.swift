//
//  ARCameraUtils.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import ARKit

struct ARCameraUtils {
    public static func frustumHeight(at distance: Float, withCamera camera: ARCamera) -> Float {
        // https://docs.unity3d.com/Manual/FrustumSizeAtDistance.html
        return 2.0 * distance * tan(camera.verticalFieldOfViewRadians * 0.5)
    }
    
    public static func frustumWidth(at distance: Float, withCamera camera: ARCamera) -> Float {
        // https://docs.unity3d.com/Manual/FrustumSizeAtDistance.html
        let frustumHeight = 2.0 * distance * tan(camera.verticalFieldOfViewRadians * 0.5)
        return frustumHeight * camera.aspectRatio
    }
    
    public static func requiredFrustumDistance(forWidth width: Float, andCamera camera: ARCamera) -> Float {
        // https://docs.unity3d.com/Manual/FrustumSizeAtDistance.html
        return (width / camera.aspectRatio) * 0.5 / tan(camera.verticalFieldOfViewRadians * 0.5)
    }
}
