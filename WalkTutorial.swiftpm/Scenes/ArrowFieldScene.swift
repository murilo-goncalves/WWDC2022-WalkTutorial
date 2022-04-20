//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 09/04/22.
//

import SpriteKit

class ArrowFieldScene: SKScene {
    
    public var arrowField: ArrowFieldNode!
    
    private let goalField = UnivecFieldNode(imageNamed: "ball", size: CGSize(width: 30, height: 30), fieldType: .ATTRACTIVE)
    
    private let obstacleField = UnivecFieldNode(imageNamed: "yellow_green", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
    
    private let player = RobotNode(imageNamed: "blue_pink", size: CGSize(width: 50, height: 50))
    
    private var movableNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacles: [obstacleField])
        goalField.position = CGPoint(x: 0, y: 0)
        obstacleField.position = CGPoint(x: 100, y: 100)
        addChild(arrowField)
        addChild(player)
        movableNode = player
        arrowField.updateArrowGrid()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let angle = arrowField.getResultingVectorAngle(at: player.position)
        let speed: CGFloat = -5
        let step = CGPoint(x: speed * cos(angle), y: speed * sin(angle))
        player.position = player.position + step
        player.zRotation = angle + CGFloat.pi / 2
        let dist = (goalField.position - player.position).abs()
        if (dist < 30) {
            player.position = frame.origin
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)
        let node = arrowField.atPoint(location!)
        
        if node is Interactive {
            let spriteNode = (node as! SKSpriteNode)
            spriteNode.glow(radius: 20)
            movableNode = spriteNode
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: arrowField)

        movableNode?.position = location!
        arrowField.updateArrowGrid()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movableNode?.stopGlow()
        movableNode = player
        arrowField.updateArrowGrid()
    }
}
