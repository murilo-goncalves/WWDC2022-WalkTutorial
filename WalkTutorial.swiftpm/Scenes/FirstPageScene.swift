//
//  FirstPageScene.swift
//  
//
//  Created by Murilo Gonçalves on 19/04/22.
//

import SpriteKit

class FirstPageScene: SKScene {
    
    public var arrowField: ArrowFieldNode!
    
    private let goalField = UnivecFieldNode(imageNamed: "ball", size: CGSize(width: 30, height: 30), fieldType: .ATTRACTIVE)
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)
        
        let xBound = SKRange(lowerLimit: frame.minX+30, upperLimit: frame.maxX-30)
        let yBound = SKRange(lowerLimit: frame.minY+30, upperLimit: frame.maxY-30)
        let goalConstraint = SKConstraint.positionX(xBound, y: yBound)
        goalField.constraints = [goalConstraint]
        
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacles: [])
        
        addChild(arrowField)
        
        arrowField.updateArrowGrid()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)
        
        goalField.position = location!
        goalField.glow(radius: 20)
        goalField.scaleUp()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)

        goalField.position = location!
        arrowField.updateArrowGrid()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        goalField.stopGlow()
        goalField.scaleDown()
        arrowField.updateArrowGrid()
    }
}
