//
//  Ground.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Ground {
    
    let ground = SKSpriteNode(imageNamed: "Ground")
    let position: CGPoint
    let size: CGSize
    
    func build() -> SKSpriteNode {
     
        ground.position = position
        ground.size = size
        
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height))
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.GroundCategory
        ground.physicsBody = physicsBody
        
        return ground
        
    }
}

