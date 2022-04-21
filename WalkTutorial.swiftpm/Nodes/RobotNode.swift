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
}

