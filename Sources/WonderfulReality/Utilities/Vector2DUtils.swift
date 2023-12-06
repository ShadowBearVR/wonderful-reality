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
                
                // Update maxY
                maxY = max(maxY, yIntersect)
            }
        }
        
        guard maxY != -Float.greatestFiniteMagnitude else {
            return nil
        }
        
        return maxY
    }
    
    public static func widthOfShape(_ points: [SIMD2<Float>], atY y: Float) -> (left: Float?, right: Float?) {
        var minLeftDistance: Float?
        var minRightDistance: Float?
        
        for i in 0 ..< points.count {
            let p1 = points[i]
            let p2 = points[(i + 1) % points.count]
            
            // Check if the line is vertical
            if p1.x == p2.x {
                let minY = min(p1.y, p2.y)
                let maxY = max(p1.y, p2.y)
                
                if y >= minY, y <= maxY {
                    let distance = abs(p1.x)
                    if p1.x < 0, minLeftDistance == nil || distance < minLeftDistance! {
                        minLeftDistance = distance
                    } else if p1.x > 0, minRightDistance == nil || distance < minRightDistance! {
                        minRightDistance = distance
                    }
                }
            } else if let (slope, yIntercept) = lineEquation(from: p1, to: p2) {
                let minY = min(p1.y, p2.y)
                let maxY = max(p1.y, p2.y)
                
                if y >= minY, y <= maxY {
                    let x = (y - yIntercept) / slope
                    let distance = abs(x)
                    
                    if x < 0, minLeftDistance == nil || distance < minLeftDistance! {
                        minLeftDistance = distance
                    } else if x > 0, minRightDistance == nil || distance < minRightDistance! {
                        minRightDistance = distance
                    }
                }
            }
        }
        
        return (minLeftDistance, minRightDistance)
    }
    
    // Helper function to calculate the slope and y-intercept of a line segment
    private static func lineEquation(from p1: SIMD2<Float>, to p2: SIMD2<Float>) -> (slope: Float, yIntercept: Float)? {
        if p1.x != p2.x {
            let slope = (p2.y - p1.y) / (p2.x - p1.x)
            let yIntercept = p1.y - slope * p1.x
            return (slope, yIntercept)
        }
        return nil
    }
}
