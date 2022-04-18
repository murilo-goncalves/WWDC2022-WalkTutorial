//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 09/04/22.
//

import SpriteKit

class ArrowFieldScene: SKScene {
    public var arrowField: ArrowFieldNode!
    private let goalField = UnivecFieldNode(imageNamed: "ball", size: CGSize(width: 30, height: 30), fieldType: .MOVE_TO_GOAL)
    private let obstacleField = UnivecFieldNode(imageNamed: "yellow_green", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
    private let player = RobotNode(imageNamed: "blue_pink", size: CGSize(width: 50, height: 50))
    private var movableNode : SKNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)
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
        player.zRotation = angle + CGFloat.pi / 2
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
