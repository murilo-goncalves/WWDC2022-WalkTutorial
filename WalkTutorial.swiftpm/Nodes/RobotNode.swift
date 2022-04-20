//
//  RobotNode.swift
//  
//
//  Created by Murilo Gonçalves on 18/04/22.
//

import Foundation
import SpriteKit

public class RobotNode: SKSpriteNode, Interactive {

    public init(imageNamed: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clear, size: size)
    }
        
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func follow(speed: CGFloat, target: CGPoint) {
        // foward motion
        let radAngle = atan2(target.y - position.y, target.x - position.x)
        self.physicsBody?.velocity = CGVector(dx: speed * cos(radAngle), dy: speed * sin(radAngle))
        
        // rotate motion
        if ((self.physicsBody?.velocity.speed())! > 0.01) {
            self.zRotation = (self.physicsBody?.velocity.angle())! - CGFloat.pi / 2
        }
    }
}

