//
//  ArrowField.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 10/04/22.
//

import SpriteKit

class ArrowFieldNode: SKNode {
    
    private static let ARROW_SIZE = CGSize(width: 15, height: 15)
    private static let ARROW_PADDING: CGFloat = 30
    private static let HALF_PI: CGFloat = CGFloat.pi / CGFloat(2)
    private static let MIN_D: CGFloat = 35
    private static let SIGMA: CGFloat = 25
    
    private let size: CGSize
    private var arrows: [Arrow] = []
    
    private var goal: UnivecFieldNode
    private var obstacles: [UnivecFieldNode]
    
    public init(size: CGSize, goal: UnivecFieldNode, obstacles: [UnivecFieldNode]) {
        self.size = size
        self.goal = goal
        self.obstacles = obstacles
        super.init()
        setArrowGrid()
        addChild(goal)
        setObstacles()
        updateArrowGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func removeArrows() {
        for arrow in arrows {
            arrow.alpha = 0
        }
    }
    
    public func setGoalField(type: FieldType) {
        goal.setField(type: type)
        updateArrowGrid()
    }
    
    public func setObstacles(_ obstacles: [UnivecFieldNode]) {
        self.obstacles = obstacles
        setObstacles()
    }
    
    public func addObstacle() {
        let obstacleNames = ["yellow_green", "yellow_pink", "yellow_purple"]
        let obstacle = UnivecFieldNode(imageNamed: obstacleNames.randomElement()!, size: CGSize(width: 50, height: 50), fieldType: .REPULSIVE)
        
        obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!, size: obstacle.size)
        obstacle.physicsBody?.usesPreciseCollisionDetection = true
        obstacle.physicsBody?.mass = 100
        
        obstacle.position = CGPoint(x: Int.random(in: 0..<Int(size.width/2 - obstacle.size.width)), y: Int.random(in: 0..<Int(size.height/2 - obstacle.size.height)))
        obstacles.append(obstacle)
        
        addChild(obstacle)
        
        updateArrowGrid()
    }
    
    public func getResultingVectorAngle(at point: CGPoint) -> CGFloat {
        let goalAngle = goal.getVectorAngle(at: point)
        
        if obstacles.isEmpty {
            return goalAngle
        }
        
        var closestObstacleDist = CGFloat.infinity
        var closestObstacle: UnivecFieldNode!
        for obstacle in obstacles {
            let dist = (obstacle.position - point).abs()
            if dist < closestObstacleDist {
                closestObstacleDist = dist
                closestObstacle = obstacle
            }
        }
        
        let repulsiveAngle = closestObstacle.getVectorAngle(at: point)
        
        if (closestObstacleDist <= ArrowFieldNode.MIN_D) {
            return repulsiveAngle
        } else {
            let gauss = gaussian(r: closestObstacleDist - ArrowFieldNode.MIN_D, s: ArrowFieldNode.SIGMA)
            return (repulsiveAngle * gauss) + (goalAngle * (1.0 - gauss))
        }
    }
    
    public func updateArrowGrid() {
        for arrow in arrows {
            let angle = getResultingVectorAngle(at: arrow.position)
            arrow.setAngle(angle)
        }
    }
    
    private func setObstacles() {
        for obstacle in obstacles {
            addChild(obstacle)
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
        let exp = -(0.5 * r * r) / (s * s)
        return pow(e, exp)
    }
}
