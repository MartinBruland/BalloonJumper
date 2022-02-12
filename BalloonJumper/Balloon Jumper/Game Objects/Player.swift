//
//  Player.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Player {
    
    let player = SKSpriteNode(imageNamed: "Character")
    var position: CGPoint
    let size: CGSize

    func build() -> SKSpriteNode {
        
        player.position = position
        player.zPosition = 5
        player.scale(to: size)
        
        
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = ContactCategories.PlayerCategory
        physicsBody.mass = 0.1
        
        physicsBody.contactTestBitMask = ContactCategories.GroundCategory | ContactCategories.CatapultCategory | ContactCategories.PlatformCategory | ContactCategories.CollectibleCategory | ContactCategories.ObstacleCategory
        
        physicsBody.collisionBitMask = ContactCategories.GroundCategory | ContactCategories.PlatformCategory | ContactCategories.CatapultCategory | ContactCategories.ObstacleCategory
        
        player.physicsBody = physicsBody
        
        return player
    }
    
}

