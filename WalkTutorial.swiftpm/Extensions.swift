//
//  Extensions.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 11/04/22.
//

import SwiftUI
import SpriteKit

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension CGPoint {
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: (left.x - right.x), y: (left.y - right.y))
    }
    
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: (left.x + right.x), y: (left.y + right.y))
    }
    
    static func *(left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    static func *(left: CGFloat, right: CGPoint) -> CGPoint {
        return CGPoint(x: right.x * left, y: right.y * left)
    }
    
    func abs() -> CGFloat {
        return sqrt(x*x + y*y)
    }
}

extension CGVector {
    func speed() -> CGFloat {
        return sqrt(dx*dx+dy*dy)
    }
    func angle() -> CGFloat {
        return atan2(dy, dx)
    }
}

extension SKSpriteNode {
    func glow(radius: CGFloat) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: texture, size: size))
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": radius])
        effectNode.zPosition = -1
    }
    
    func scaleUp() {
        let scaleUpAction = SKAction.scale(to: 1.3, duration: 0.2)
        run(scaleUpAction)
    }
    func scaleDown() {
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.2)
        run(scaleDownAction)
    }
    
    func pulse() {
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        
        run(SKAction.sequence([scaleUpAction, scaleDownAction]))
    }
    
    func stopGlow() {
        _ = self.children.map( { $0.run(SKAction.fadeOut(withDuration: 0.3)) })
    }
}
