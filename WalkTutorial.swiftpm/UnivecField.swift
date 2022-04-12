//
//  File.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 11/04/22.
//

import CoreGraphics

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
    private var fieldFunction: FieldFunction {
        switch fieldType {
        case .ATTRACTIVE:
            return attractive(target:)
        case .REPULSIVE:
            return repulsive(target:)
        case .CW_SPIRAL:
            return cwSpiral(target:)
        case .CCW_SPIRAL:
            return ccwSpiral(target:)
        }
    }
    
    private var origin: CGPoint
    
    public init(origin: CGPoint, fieldType: FieldType) {
        self.origin = origin
        self.fieldType = fieldType
    }
    
    public func getOrigin() -> CGPoint {
        return origin
    }
    
    public func setField(type: FieldType) {
        fieldType = type
    }
    
    public func getVectorAngle(at point: CGPoint) -> CGFloat {
        return fieldFunction(point)
    }
    
    public func setOrigin(to point: CGPoint) {
        origin = point
    }
    
    private func attractive(target: CGPoint) -> CGFloat {
        return atan2(target.y - origin.y, target.x - origin.x)
    }
    
    private func repulsive(target: CGPoint) -> CGFloat {
        return atan2(origin.y - target.y, origin.x - target.x)
    }
    
    private func spiral(target: CGPoint, is_cw: Bool) -> CGFloat {
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
    
    private func cwSpiral(target: CGPoint) -> CGFloat {
        return spiral(target: target, is_cw: true)
    }
    
    private func ccwSpiral(target: CGPoint) -> CGFloat {
        return spiral(target: target, is_cw: false)
    }
}
