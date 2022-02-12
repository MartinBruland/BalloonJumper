//
//  HighscorePin.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct HighscorePin {
    
    let highscoreMarker = SKSpriteNode()
    let position: CGPoint
    
    func build() -> SKSpriteNode {
        
        highscoreMarker.color = states.borderColor
        highscoreMarker.size = CGSize(width: UIScreen.main.bounds.width, height: 2.0)
        highscoreMarker.position = position
        highscoreMarker.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        let textnode = SKLabelNode(fontNamed: states.fontName)
        textnode.fontSize = 10
        textnode.fontColor = states.borderColor
        textnode.position = CGPoint(x: highscoreMarker.frame.maxX - 50, y: 10.0)
        textnode.text = "Highscore: \(states.convertPositionToAltitude(position: states.highscorePositionY))"
        highscoreMarker.addChild(textnode)
        
        return highscoreMarker
    }
    
    func removePin() {
        highscoreMarker.removeFromParent()
    }
    
}

