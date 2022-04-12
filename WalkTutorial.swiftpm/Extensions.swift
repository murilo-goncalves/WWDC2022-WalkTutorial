//
//  Extensions.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 11/04/22.
//

import CoreGraphics

extension CGPoint {
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: (left.x - right.x), y: (left.y - right.y))
    }
    
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: (left.x + right.x), y: (left.y + right.y))
    }
    
    func abs() -> CGFloat {
        return sqrt(x*x + y*y)
    }
}
