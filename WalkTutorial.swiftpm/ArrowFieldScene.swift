//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 09/04/22.
//

import SpriteKit

//
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

class ArrowFieldScene: SKScene {
    var field: ArrowField!
    let goal = SKShapeNode(circleOfRadius: 10)
    let player = SKShapeNode(circleOfRadius: 10)
    var movableNode : SKNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        field = ArrowField(size: frame.size)
        addChild(field)
        backgroundColor = .white
        goal.fillColor = .red
        goal.position = .zero
        player.fillColor = .blue
        player.position = .zero
        addChild(goal)
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let angle = field.getResultingVectorAngle(at: player.position)
        let speed: CGFloat = -5
        let step = CGPoint(x: speed * cos(angle), y: speed * sin(angle))
        player.position = player.position + step
        let dist = (goal.position - player.position).abs()
        if (dist < 10) {
            player.position = frame.origin
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = self.atPoint(location!)
        if (node == goal) {
            movableNode = goal
        } else {
            movableNode = player
            player.position = location!
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        
        if (movableNode == goal) {
            field.updateArrowGrid()
        }
        
        movableNode?.position = location!
    }
}
