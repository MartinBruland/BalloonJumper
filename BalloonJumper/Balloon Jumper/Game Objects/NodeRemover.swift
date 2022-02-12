//
//  NodeRemover.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct NodeRemover {
    
    let nodeRemover = SKSpriteNode()
    var position: CGPoint
    let size: CGSize
    
    func build() -> SKSpriteNode {
        
        nodeRemover.position = position
        nodeRemover.size = size
    
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height))
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = false
        physicsBody.pinned = true
        physicsBody.allowsRotation = false
        physicsBody.categoryBitMask = ContactCategories.NodeRemoverCategory
        
        physicsBody.contactTestBitMask = ContactCategories.PlatformCategory | ContactCategories.CollectibleCategory | ContactCategories.ObstacleCategory | ContactCategories.GroundCategory | ContactCategories.CatapultCategory
        
        nodeRemover.physicsBody = physicsBody
    
        return nodeRemover
        
    }
    
}

