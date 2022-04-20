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
    
    private let player = RobotNode(imageNamed: "blue_pink", size: CGSize(width: 50, height: 50))
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 1, green: 0.937, blue: 0.776, alpha: 1)
        
        arrowField = ArrowFieldNode(size: frame.size, goal: goalField, obstacles: createObstacles())

        goalField.position = CGPoint(x: -300, y: 0)
        player.position = CGPoint(x: 300, y: 0)
        
        arrowField.removeArrows()
        
        addChild(arrowField)
        addChild(player)
        
        player.glow(radius: 20)
        
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
            player.position = CGPoint(x: 300, y: 0)
        }
    }
    
    private func createObstacles() -> [UnivecFieldNode] {
        let obstacle1 = UnivecFieldNode(imageNamed: "yellow_green", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
        obstacle1.position = CGPoint(x: 200, y: 0)
        
        let obstacle2 = UnivecFieldNode(imageNamed: "yellow_pink", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
        obstacle2.position = CGPoint(x: 30, y: -100)
        obstacle2.zRotation = 40
        
        let obstacle3 = UnivecFieldNode(imageNamed: "yellow_purple", size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
        obstacle3.position = CGPoint(x: -160, y: 20)
        obstacle3.zRotation = 20
        
        return [obstacle1, obstacle2, obstacle3]
    }
}
