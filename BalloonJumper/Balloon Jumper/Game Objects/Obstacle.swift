//
//  Obstacle.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Obstacle {
    
    let obstacle = SKSpriteNode(imageNamed: "Obstacle_1")
    let position: CGPoint
    let size: CGSize
    
    func build() -> SKSpriteNode {
        
        obstacle.position = position
        obstacle.size = size
        obstacle.zPosition = 10
     
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.ObstacleCategory
        physicsBody.collisionBitMask = 0
        obstacle.physicsBody = physicsBody

        return obstacle
    }

    
    func add_movement() {
        
        obstacle.position = CGPoint(x: UIScreen.main.bounds.minX, y: self.position.y)
        
        let action1 = SKAction.moveTo(x: UIScreen.main.bounds.maxX, duration: 4.0)
        let action2 = SKAction.moveTo(x: UIScreen.main.bounds.minX, duration: 4.0)
        let animation = SKAction.sequence([action1, action2])
        
        obstacle.run(SKAction.repeatForever(animation))
        
    }
}

