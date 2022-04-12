//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 10/04/22.
//

import SpriteKit

class ArrowFieldNode: SKNode {
    
    private static let ARROW_SIZE = CGSize(width: 10, height: 10)
    private static let ARROW_PADDING: CGFloat = 20
    private static let HALF_PI: CGFloat = CGFloat.pi / CGFloat(2)
    private static let MIN_D: CGFloat = 50
    private static let SIGMA: CGFloat = 10
    
    private let size: CGSize
    private var arrows: [Arrow] = []
    
    private var goal: UnivecFieldNode
    private var obstacle: UnivecFieldNode
    
    public init(size: CGSize, goal: UnivecFieldNode, obstacle: UnivecFieldNode) {
        self.size = size
        self.goal = goal
        self.obstacle = obstacle
        super.init()
        addChild(goal)
        addChild(obstacle)
        setArrowGrid()
        updateArrowGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public func add(obstacle: UnivecField) {
//        obstacles.append(obstacle)
//        let sprite = SKShapeNode(circleOfRadius: 10)
//        sprite.fillColor = .blue
//        sprite.position = obstacle.getOrigin()
//        addChild(sprite)
//        updateArrowGrid()
//    }
    
    public func getResultingVectorAngle(at point: CGPoint) -> CGFloat {
        let goalAngle = goal.getVectorAngle(at: point)
        let repulsiveAngle = obstacle.getVectorAngle(at: point)
//        for obstacle in obstacles {
//            repulsiveAngle += (obstacle.getVectorAngle(at: point) / CGFloat(obstacles.count))
//        }
        
        let obstacleDist = (obstacle.position - point).abs()
        
        if (obstacleDist < ArrowFieldNode.MIN_D) {
            return repulsiveAngle
        } else {
            let gauss = gaussian(r: obstacleDist - ArrowFieldNode.MIN_D, s: ArrowFieldNode.SIGMA)
            return repulsiveAngle * gauss + goalAngle * (1 - gauss)
        }
    }
    
    public func updateArrowGrid() {
        for arrow in arrows {
            let angle = getResultingVectorAngle(at: arrow.position)
            arrow.setAngle(angle)
        }
    }
    
    private func setArrowGrid() {
        arrows = []
        for x in stride(from: -size.width/2 + ArrowFieldNode.ARROW_PADDING,
                        to: size.width/2,
                        by: ArrowFieldNode.ARROW_PADDING) {
            for y in stride(from: -size.height/2 + ArrowFieldNode.ARROW_PADDING,
                            to: size.height/2,
                            by: ArrowFieldNode.ARROW_PADDING) {
                let arrow = Arrow(size: ArrowFieldNode.ARROW_SIZE)
                arrow.position = CGPoint(x: x, y: y)
                arrows.append(arrow)
                addChild(arrow)
            }
        }
    }
    
    private func gaussian(r: CGFloat, s: CGFloat) -> CGFloat {
        let e: CGFloat = 2.7182
        let exp = (-0.5 * r * r) / (s * s)
        return pow(e, exp);
    }
}
