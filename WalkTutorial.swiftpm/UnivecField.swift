//
//  File.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 11/04/22.
//

import CoreGraphics

typealias FieldFunction = (CGPoint, CGPoint) -> CGFloat

// -TODO: MOVE_TO_GOAL
enum FieldType {
    case ATTRACTIVE
    case REPULSIVE
    case CW_SPIRAL
    case CCW_SPIRAL
}

class UnivecField {
    private static let HALF_PI: CGFloat = CGFloat.pi / CGFloat(2)
    private static let R: CGFloat = 500 // spiral radius
    private static let K: CGFloat = 100 // spiral constant
    
    private var fieldType: FieldType
    
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
        }
    }
    
    public init(fieldType: FieldType) {
        self.fieldType = fieldType
    }
    
    public func setField(type: FieldType) {
        fieldType = type
    }
    
    private func attractive(origin: CGPoint, target: CGPoint) -> CGFloat {
        return atan2(target.y - origin.y, target.x - origin.x)
    }
    
    private func repulsive(origin: CGPoint, target: CGPoint) -> CGFloat {
        return atan2(origin.y - target.y, origin.x - target.x)
    }
    
    private func spiral(origin: CGPoint, target: CGPoint, is_cw: Bool) -> CGFloat {
        let sgn = is_cw ? 1.0 : -1.0
        let dist = (target - origin).abs()
        let phi = atan2(target.y - origin.y, target.x - origin.x)
        if (dist > UnivecField.R) {
            let angle = phi + (sgn) * UnivecField.HALF_PI * (2.0 - ((UnivecField.R + UnivecField.K) / (dist + UnivecField.K)))
            return angle
        } else {
            let angle = phi + (sgn) * UnivecField.HALF_PI * sqrt(dist / UnivecField.R)
            return angle
        }
    }
    
    private func cwSpiral(origin: CGPoint, target: CGPoint) -> CGFloat {
        return spiral(origin: origin, target: target, is_cw: true)
    }
    
    private func ccwSpiral(origin: CGPoint, target: CGPoint) -> CGFloat {
        return spiral(origin: origin, target: target, is_cw: false)
    }
}
