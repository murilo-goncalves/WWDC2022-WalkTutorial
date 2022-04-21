//
//  File.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 11/04/22.
//

import CoreGraphics
import SwiftUI

typealias FieldFunction = (CGPoint, CGPoint) -> CGFloat

enum FieldType {
    case ATTRACTIVE
    case REPULSIVE
    case CW_SPIRAL
    case CCW_SPIRAL
    case MOVE_TO_GOAL
}

class UnivecField {
    private static let HALF_PI: CGFloat = CGFloat.pi / CGFloat(2)
    private static let R: CGFloat = 30 // spiral radius
    private static let K: CGFloat = 300 // spiral constant
    
    public var fieldType: FieldType
    
    public var fieldFunction: FieldFunction {
        switch fieldType {
        case .ATTRACTIVE:
            return attractive(origin:target:)
        case .REPULSIVE:
            return repulsive(origin:target:)
        case .CW_SPIRAL:
            return cwSpiral(origin:target:)
        case .CCW_SPIRAL:
            return ccwSpiral(origin:target:)
        case .MOVE_TO_GOAL:
            return moveGoalToLeft(origin:target:)
        }
    }
    
    public init(fieldType: FieldType) {
        self.fieldType = fieldType
    }
    
    private func attractive(origin: CGPoint, target: CGPoint) -> CGFloat {
        return atan2(target.y - origin.y, target.x - origin.x)
    }
    
    private func repulsive(origin: CGPoint, target: CGPoint) -> CGFloat {
        return atan2(origin.y - target.y, origin.x - target.x)
    }
    
    private func spiral(origin: CGPoint, target: CGPoint, is_cw: Bool) -> CGFloat {
        let sgn = is_cw ? -1.0 : 1.0
        let dist = (target - origin).abs()
        let phi = atan2(target.y - origin.y, target.x - origin.x)
        if (dist > UnivecField.R) {
            let angle = phi + (sgn) * UnivecField.HALF_PI * (2.0 - ((UnivecField.R + UnivecField.K) / (dist + UnivecField.K)))
            return angle + CGFloat.pi
        } else {
            let angle = phi + (sgn) * UnivecField.HALF_PI * sqrt(dist / UnivecField.R)
            return angle + CGFloat.pi
        }
    }
    
    private func cwSpiral(origin: CGPoint, target: CGPoint) -> CGFloat {
        return spiral(origin: origin, target: target, is_cw: true)
    }
    
    private func ccwSpiral(origin: CGPoint, target: CGPoint) -> CGFloat {
        return spiral(origin: origin, target: target, is_cw: false)
    }
    
    private func moveGoalToLeft(origin: CGPoint, target: CGPoint) -> CGFloat {
        let angle: CGFloat
        let translated = origin - target
        let yl = translated.y + UnivecField.R
        let yr = translated.y - UnivecField.R
        
        if (-UnivecField.R <= translated.y && translated.y < UnivecField.R) {
            let angleCw = cwSpiral(origin: origin, target: target)
            let angleCcw = ccwSpiral(origin: origin, target: target)
            let nCw = CGPoint(x: cos(angleCw), y: sin(angleCw))
            let nCcw = CGPoint(x: cos(angleCcw), y: sin(angleCcw))
            let tmp: CGPoint = (yl * nCcw - yr * nCw) * (1.0 / (2.0 * UnivecField.R))
            angle = -atan2(tmp.y, tmp.x)
        } else if (translated.y < -UnivecField.R) {
            return ccwSpiral(origin: origin, target: target)
        } else {
            return cwSpiral(origin: origin, target: target)
        }
        return angle
    }
}
