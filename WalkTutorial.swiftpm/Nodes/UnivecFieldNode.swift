//
//  FieldNode.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 12/04/22.
//

import SpriteKit

class UnivecFieldNode: SKSpriteNode {
    private let field: UnivecField
    
    public init(imageNamed: String, size: CGSize, fieldType: FieldType) {
        field = UnivecField(fieldType: fieldType)
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clear, size: size)
    }

    public func getVectorAngle(at point: CGPoint) -> CGFloat {
        return field.fieldFunction(position, point)
    }
    
    public func setField(type: FieldType) {
        field.fieldType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
