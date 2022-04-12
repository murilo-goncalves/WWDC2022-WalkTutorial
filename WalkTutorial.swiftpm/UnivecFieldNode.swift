//
//  FieldNode.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 12/04/22.
//

import SpriteKit

class UnivecFieldNode: SKShapeNode {
    let field: UnivecField
    
    public init(fieldType: FieldType) {
        field = UnivecField(fieldType: fieldType)
        super.init()
        let diameter = 20
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -diameter / 2, y: -diameter / 2), size: CGSize(width: diameter, height: diameter)), transform: nil)
        self.fillColor = .blue
    }
    
    public func getVectorAngle(at point: CGPoint) -> CGFloat {
        return field.fieldFunction(position, point)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
