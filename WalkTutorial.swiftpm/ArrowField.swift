//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 10/04/22.
//

import SpriteKit

typealias FieldFunction = (CGPoint) -> CGFloat

class ArrowField: SKNode {
    
    private static let ARROW_SIZE = CGSize(width: 10, height: 10)
    private static let ARROW_PADDING: CGFloat = 20
    private static let HALF_PI: CGFloat = CGFloat.pi / CGFloat(2)
    
    private let size: CGSize
    private var arrows: [Arrow] = []
    private var fields: [UnivecField] = []
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        setArrowGrid()
        
        updateArrowGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func add(field: UnivecField) {
        fields.append(field)
    }
    
    public func getResultingVectorAngle(at point: CGPoint) -> CGFloat {
        var angle: CGFloat = 0
        for field in fields {
            angle += field.getVectorAngle(at: point)
        }
        
        return angle
    }
    
    public func updateArrowGrid() {
        for arrow in arrows {
            let angle = getResultingVectorAngle(at: arrow.position)
            arrow.setAngle(angle)
        }
    }
    
    private func setArrowGrid() {
        arrows = []
        for x in stride(from: -size.width/2 + ArrowField.ARROW_PADDING,
                        to: size.width/2,
                        by: ArrowField.ARROW_PADDING) {
            for y in stride(from: -size.height/2 + ArrowField.ARROW_PADDING,
                            to: size.height/2,
                            by: ArrowField.ARROW_PADDING) {
                let arrow = Arrow(size: ArrowField.ARROW_SIZE)
                arrow.position = CGPoint(x: x, y: y)
                arrows.append(arrow)
                addChild(arrow)
            }
        }
    }
    
    private func setFields() {
        for field in fields {
            let sprite = SKShapeNode(circleOfRadius: 20)
            sprite.fillColor = .blue
            sprite.position = field.getOrigin()
            addChild(sprite)
        }
    }
}
