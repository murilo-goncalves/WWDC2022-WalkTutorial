//
//  IntroAnimationScene.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 18/04/22.
//

import SpriteKit

class IntroAnimationScene: SKScene {
    public var arrowField: ArrowFieldNode!
    private let goalField = UnivecFieldNode(imageNamed: "ball", size: CGSize(width: 30, height: 30), fieldType: .ATTRACTIVE)
    private let obstacleField = UnivecFieldNode(imageNamed: "yellow_green", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
    private let player = RobotNode(imageNamed: "blue_pink", size: CGSize(width: 50, height: 50))
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)

        obstacleField.position = CGPoint(x: 200, y: 200)
        goalField.position = CGPoint(x: 200, y: 0)
        player.position = CGPoint(x: -200, y: 0)
        
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacle: obstacleField)
        
        arrowField.updateArrowGrid()
        
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
}
