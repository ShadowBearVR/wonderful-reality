//
//  Vector2DUtils.swift
//  WonderfulReality
//
//  Created by Collin MacDonald on 11/25/23.
//

import simd

public enum Vector2DUtils {
    public static func rotatePoints(points: [SIMD2<Float>], angleDegrees: Float) -> [SIMD2<Float>] {
        var rotatedPoints: [SIMD2<Float>] = []
        
        let angleRadians = angleDegrees * (.pi / 180.0)
        let cosTheta = cos(angleRadians)
        let sinTheta = sin(angleRadians)
        
        for point in points {
            let x = point.x
            let y = point.y
            
            let newX = cosTheta * x - sinTheta * y
            let newY = sinTheta * x + cosTheta * y
            
            rotatedPoints.append(SIMD2<Float>(x: newX, y: newY))
        }
        
        return rotatedPoints
    }
    
    public static func projectOntoPlane(origin: SIMD3<Float>, points: [SIMD3<Float>], yAxisVector: SIMD3<Float>, xAxisVector: SIMD3<Float>) -> [SIMD2<Float>] {
        // Normalize the provided vectors
        let u1 = normalize(xAxisVector)
        let u2 = normalize(yAxisVector)
        
        // Projecting the points onto the 2D plane formed by the provided orthogonal vectors
        var projectedPoints: [SIMD2<Float>] = []
        
        for p in points {
            let newP = p - origin
            let xComponent = dot(newP, u1)
            let yComponent = dot(newP, u2)
            let projectedPoint = SIMD2<Float>(xComponent, yComponent)
            projectedPoints.append(projectedPoint)
        }
        
        return projectedPoints
    }
    
    public static func widthOfShape(atY yValue: Float, forPoints points: [SIMD2<Float>]) -> (Float, Float)? {
        var minX = Float.greatestFiniteMagnitude
        var maxX: Float = -Float.greatestFiniteMagnitude
        
        for i in 0 ..< points.count {
            let current = points[i]
            let next = points[(i + 1) % points.count]
            
            // Check if the line segment intersects with Y=yValue
            let signs = SIMD2<Float>(current.y - yValue, next.y - yValue)
            if signs.x * signs.y <= 0 {
                // Linear interpolation using SIMD operations
                let deltaY = next.y - current.y
                let deltaX = next.x - current.x
                let t = (yValue - current.y) / deltaY
                let xIntersect = current.x + t * deltaX
                
                // Update minX and maxX
                minX = min(minX, xIntersect)
                maxX = max(maxX, xIntersect)
            }
        }
        
        guard minX != Float.greatestFiniteMagnitude, maxX != -Float.greatestFiniteMagnitude else {
            return nil
        }
        
        return (abs(minX), abs(maxX))
    }
    
    public static func depthOfShape(atX xValue: Float, forPoints points: [SIMD2<Float>]) -> Float? {
        var minY = Float.greatestFiniteMagnitude
        var maxY: Float = -Float.greatestFiniteMagnitude
        
        for i in 0 ..< points.count {
            let current = points[i]
            let next = points[(i + 1) % points.count]
            
            // Check if the line segment intersects with X=xValue
            let signs = SIMD2<Float>(current.x - xValue, next.x - xValue)
            if signs.x * signs.y <= 0 {
                // Linear interpolation using SIMD operations
                let deltaX = next.x - current.x
                let deltaY = next.y - current.y
                let t = (xValue - current.x) / deltaX
                let yIntersect = current.y + t * deltaY
                
                // Update minY and maxY
                minY = min(minY, yIntersect)
                maxY = max(maxY, yIntersect)
            }
        }
        
        guard minY != Float.greatestFiniteMagnitude, maxY != -Float.greatestFiniteMagnitude else {
            return nil
        }
        
        return maxY - minY
    }
}
