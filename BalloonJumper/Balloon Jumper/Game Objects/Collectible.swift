//
//  Collectible.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Collectible {
    
    let collectible = SKSpriteNode()
    var position: CGPoint
    var size: CGSize
    
    func setup() {
        
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.CollectibleCategory
        physicsBody.collisionBitMask = 0
        physicsBody.fieldBitMask = ContactCategories.PlayerCategory
        
        collectible.position = position
        collectible.size = size
        collectible.physicsBody = physicsBody
        
    }
    
    func build() -> SKSpriteNode {
    
        setup()
        collectible.texture = SKTexture(imageNamed: "Collectible_Coin")
        collectible.name = "COLLECTIBLE_COIN"
        return collectible
        
    }
    
    func getRandomShape() -> Array<CGPoint> {
        
        let shape1 = CollectibleShapes(basePosition: CGPoint(x: position.x, y: position.y)).arrow(size: size)
        let shape2 = CollectibleShapes(basePosition: CGPoint(x: position.x, y: position.y)).single(size: size)
        let shape3 = CollectibleShapes(basePosition: CGPoint(x: position.x, y: position.y)).smiley(size: size)
        
        let allShapes = [shape1, shape2, shape3]
        let randomNumber = Int(arc4random_uniform(UInt32(allShapes.count)))
        let randomShape = allShapes[randomNumber]
        
        return randomShape
    }
}

struct CollectibleShapes {
    
    let basePosition: CGPoint
    
    func single(size: CGSize) -> Array<CGPoint> {
        
        let shape = [
            CGPoint(x: basePosition.x, y: basePosition.y),
        ]
        return shape
    }
        
    func smiley(size: CGSize) -> Array<CGPoint> {
        
        let shape = [
            CGPoint(x: basePosition.x + size.width, y: basePosition.y + (size.width*1.3)),
            CGPoint(x: basePosition.x - size.width, y: basePosition.y + (size.width*1.3)),
            CGPoint(x: basePosition.x, y: basePosition.y - (size.width*2.2)),
            CGPoint(x: basePosition.x - (size.width*1.1), y: basePosition.y - (size.width*1.8)),
            CGPoint(x: basePosition.x + (size.width*1.1), y: basePosition.y - (size.width*1.8)),
            CGPoint(x: basePosition.x - (size.width*1.7), y: basePosition.y - (size.width*0.8)),
            CGPoint(x: basePosition.x + (size.width*1.7), y: basePosition.y - (size.width*0.8)),
        ]
        return shape
    }

    func arrow(size: CGSize) -> Array<CGPoint> {
        
        let shape = [
            CGPoint(x: basePosition.x, y: basePosition.y),
            CGPoint(x: basePosition.x, y: basePosition.y - (size.width*1.2)),
            CGPoint(x: basePosition.x, y: basePosition.y + (size.width*1.2)),
            CGPoint(x: basePosition.x, y: basePosition.y - (size.width*2.4)),
            CGPoint(x: basePosition.x - (size.width*1.8), y: basePosition.y - (size.width*0.3) ),
            CGPoint(x: basePosition.x + (size.width*1.8), y: basePosition.y - (size.width*0.3) ),
            CGPoint(x: basePosition.x - size.width, y: basePosition.y + (size.width*0.5)),
            CGPoint(x: basePosition.x + size.width, y: basePosition.y + (size.width*0.5)),
        ]
        return shape
    }
}

