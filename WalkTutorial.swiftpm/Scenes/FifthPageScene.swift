//
//  FifthPageScene.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 20/04/22.
//

import SpriteKit

class FifthPageScene: SKScene {
    
    public var arrowField: ArrowFieldNode!
    
    private let goalField = UnivecFieldNode(imageNamed: "ball", size: CGSize(width: 30, height: 30), fieldType: .CW_SPIRAL)
    
    private let player = RobotNode(imageNamed: "blue_pink", size: CGSize(width: 50, height: 50))
    private var playerSpeed: CGFloat = -5
    
    private var movableNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)
        
        setFieldFrameConstraints(node: goalField)
        setFieldFrameConstraints(node: player)
        
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacles: [])
        
        addChild(arrowField)
        
        player.position = frame.origin
        movableNode = player
        arrowField.addChild(player)
        
        arrowField.updateArrowGrid()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let angle = arrowField.getResultingVectorAngle(at: player.position)
        let speed = playerSpeed
        let step = CGPoint(x: speed * cos(angle), y: speed * sin(angle))
        player.position = player.position + step
        player.zRotation = angle + CGFloat.pi / 2
        
        let dist = (goalField.position - player.position).abs()
        if (dist < 40 && playerSpeed != 0) {
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
            spriteNode.scaleUp()
            movableNode = spriteNode
        } else {
            movableNode?.glow(radius: 20)
            movableNode?.scaleUp()
            movableNode?.position = location!
//            arrowField.add(obstacle: UnivecFieldNode(imageNamed: "yellow_green", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE))
        }
        
        if movableNode == player {
            playerSpeed = 0
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
        movableNode?.scaleDown()
        movableNode = player
        arrowField.updateArrowGrid()
        playerSpeed = -5
    }
    
    private func setFieldFrameConstraints(node: SKSpriteNode) {
        let xBound = SKRange(lowerLimit: frame.minX+node.size.width, upperLimit: frame.maxX-node.size.width)
        let yBound = SKRange(lowerLimit: frame.minY+node.size.width, upperLimit: frame.maxY-node.size.width)
        let fieldConstraint = SKConstraint.positionX(xBound, y: yBound)
        node.constraints = [fieldConstraint]
    }
}

