//
//  Platform.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Platform {
    
    let platform = SKSpriteNode()
    let position: CGPoint
    let size: CGSize
    
    func buildPlatform1() -> SKSpriteNode {
        
        let platformAssets = [SKTexture(imageNamed: "Balloon_N1"), SKTexture(imageNamed: "Balloon_N2"), SKTexture(imageNamed: "Balloon_N3"), SKTexture(imageNamed: "Balloon_N4"), SKTexture(imageNamed: "Balloon_N5"), SKTexture(imageNamed: "Balloon_N6")]
    
        let randomNumber = Int(arc4random_uniform(UInt32(platformAssets.count)))
        
        platform.texture = platformAssets[randomNumber]
        platform.name = "Balloon_Normal"
        platform.size = size
        platform.position = position
        
        let physicsBody = SKPhysicsBody(circleOfRadius: platform.size.width / 1.5)
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.PlatformCategory
        platform.physicsBody = physicsBody
        
        return platform
    }
    
    func buildPlatform2() -> SKSpriteNode {
        
        let platformAssets = [SKTexture(imageNamed: "Balloon_L1"), SKTexture(imageNamed: "Balloon_L2"), SKTexture(imageNamed: "Balloon_L3"), SKTexture(imageNamed: "Balloon_L4"), SKTexture(imageNamed: "Balloon_L5"), SKTexture(imageNamed: "Balloon_L6")]
    
        let randomNumber = Int(arc4random_uniform(UInt32(platformAssets.count)))
        
        platform.texture = platformAssets[randomNumber]
        platform.name = "Balloon_Long"
        platform.size = size
        platform.position = position
        
        let physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.PlatformCategory
        physicsBody.contactTestBitMask = ContactCategories.PlayerCategory | ContactCategories.NodeRemoverCategory
        
        platform.physicsBody = physicsBody
        
        return platform
    }
    
    func buildPlatform3() -> SKSpriteNode {
        
        let platformAssets = [SKTexture(imageNamed: "Balloon_F1"), SKTexture(imageNamed: "Balloon_F2"), SKTexture(imageNamed: "Balloon_F3"), SKTexture(imageNamed: "Balloon_F4"), SKTexture(imageNamed: "Balloon_F5"), SKTexture(imageNamed: "Balloon_F6")]
    
        let randomNumber = Int(arc4random_uniform(UInt32(platformAssets.count)))
        
        platform.texture = platformAssets[randomNumber]
        platform.name = "Balloon_Fragile"
        platform.size = size
        platform.position = position
        
        let physicsBody = SKPhysicsBody(circleOfRadius: platform.size.width / 1.5)
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = ContactCategories.PlatformCategory
        physicsBody.contactTestBitMask = ContactCategories.PlayerCategory | ContactCategories.NodeRemoverCategory
        
        platform.physicsBody = physicsBody
        
        return platform
    }
    
    func addPlatformMovement() {
        
        let basePosition = position.x
        var randomX = CGFloat(0)
        
        if basePosition > UIScreen.main.bounds.midX {
            randomX = UIScreen.main.bounds.minX + 30
        } else {
            randomX = UIScreen.main.bounds.maxX - 30
        }
        
        let action1 = SKAction.moveTo(x: randomX, duration: 4.0)
        let action2 = SKAction.moveTo(x: basePosition, duration: 4.0)
        let animation = SKAction.repeatForever(SKAction.sequence([action1, action2]))
        
        platform.run(animation)
        
    }
}

