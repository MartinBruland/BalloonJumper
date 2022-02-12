//
//  SoundEffects.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct SoundEffects {
    
    let platformSound1 = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false) // Platform Type 1
    let platformSound2 = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false) // Platform Type 2
    let platformSound3 = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false) // Platform Type 3
    let collectibleSound1 = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false) // Collectible Type 1
    let collectibleSound2 = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false) // Collectible Type 2
    
    func playSound(scene: SKScene, action: SKAction) {
        
        scene.removeAllActions()
        scene.run(action)
        
    }
}
