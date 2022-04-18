//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 09/04/22.
//

import SpriteKit

class ArrowFieldScene: SKScene {
    var arrowField: ArrowFieldNode!
    let goalField = UnivecFieldNode(fieldType: .MOVE_TO_GOAL)
    let obstacleField = UnivecFieldNode(fieldType: .REPULSIVE)
    let player: SKShapeNode = {
        let ball = SKShapeNode(circleOfRadius: 10)
        ball.position = .zero
        ball.fillColor = .red
        return ball
    }()
    var movableNode : SKNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .white
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacle: obstacleField)
        arrowField.updateArrowGrid()
        obstacleField.position = CGPoint(x: 100, y: 100)
        addChild(arrowField)
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let angle = arrowField.getResultingVectorAngle(at: player.position)
        let speed: CGFloat = -5
        let step = CGPoint(x: speed * cos(angle), y: speed * sin(angle))
        player.position = player.position + step
        let dist = (goalField.position - player.position).abs()
        if (dist < 10) {
            player.position = frame.origin
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)
        let node = self.atPoint(location!)
        movableNode = node
        
        player.position = location!
        arrowField.updateArrowGrid()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)

//        movableNode?.position = location!
    }
}
