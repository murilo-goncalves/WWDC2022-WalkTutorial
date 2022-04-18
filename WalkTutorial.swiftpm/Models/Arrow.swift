//
//  Arrow.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 07/04/22.
//

import SwiftUI
import SpriteKit

class Arrow: SKSpriteNode {
    let arrowTxt = SKTexture(imageNamed: "arrow.png")
    
    public init(size: CGSize) {
        super.init(texture: arrowTxt, color: .black, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAngle(_ angle: CGFloat) {
        zRotation = angle
    }
}
