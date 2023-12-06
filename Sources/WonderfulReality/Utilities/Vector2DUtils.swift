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
    
    public static func widthOfShape(shape: [SIMD2<Float>], atY y: Float) -> (Float, Float)? {
        guard let leftWidth = leftDistance(shape: shape, atY: y) else { return nil }
        guard let rightWidth = rightDistance(shape: shape, atY: y) else { return nil }
        
        return (abs(leftWidth), abs(rightWidth))
    }
    
    public static func depthOfShape(atX xValue: Float, forPoints points: [SIMD2<Float>]) -> Float? {
        var maxY = -Float.greatestFiniteMagnitude
        
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
                maxY = max(maxY, yIntersect)
            }
        }
        
        guard maxY != -Float.greatestFiniteMagnitude else {
            return nil
        }
        
        return maxY
    }
    
    private static func rightDistance(shape: [SIMD2<Float>], atY y: Float) -> Float? {
        var closestDistance: Float?
        
        for i in 0..<shape.count {
            let p1 = shape[i]
            let p2 = shape[(i + 1) % shape.count]
            
            // Check if edge crosses the given y value
            if (p1.y - y) * (p2.y - y) < 0 {
                // Calculate intersection point
                let dx = p2.x - p1.x
                let dy = p2.y - p1.y
                let t = (y - p1.y) / dy
                let xIntersect = p1.x + t * dx
                
                // Only consider points to the right of origin
                if xIntersect > 0 {
                    let distance = hypot(xIntersect, y)
                    if let currentClosest = closestDistance {
                        closestDistance = min(currentClosest, distance)
                    } else {
                        closestDistance = distance
                    }
                }
            }
        }
        
        return closestDistance
    }
    
    private static func leftDistance(shape: [SIMD2<Float>], atY y: Float) -> Float? {
        var closestDistance: Float?
        
        for i in 0..<shape.count {
            let p1 = shape[i]
            let p2 = shape[(i + 1) % shape.count]
            
            // Check if edge crosses the given y value
            if (p1.y - y) * (p2.y - y) < 0 {
                // Calculate intersection point
                let dx = p2.x - p1.x
                let dy = p2.y - p1.y
                let t = (y - p1.y) / dy
                let xIntersect = p1.x + t * dx
                
                // Only consider points to the left of origin
                if xIntersect < 0 {
                    let distance = hypot(xIntersect, y)
                    if let currentClosest = closestDistance {
                        closestDistance = min(currentClosest, distance)
                    } else {
                        closestDistance = distance
                    }
                }
            }
        }
        
        return closestDistance
    }

}
