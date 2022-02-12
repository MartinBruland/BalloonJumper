//
//  Catapult.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Catapult {
    
    let catapult = SKSpriteNode(imageNamed: "Balloon_L1")
    let position: CGPoint
    let size: CGSize
    
    func build() -> SKSpriteNode {
        
        catapult.position = position
        catapult.size = size
        catapult.zPosition = 5
        
        let physicsBody = SKPhysicsBody(rectangleOf: catapult.size)
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.CatapultCategory
        catapult.physicsBody = physicsBody
        
        return catapult
        
    }

}

