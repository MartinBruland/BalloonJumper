//
//  HeaderUI.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct Hud {

    let HudUI = SKSpriteNode()
    var label1 = SKLabelNode()
    var label2 = SKLabelNode()
    
    func build() -> SKSpriteNode {
    
        HudUI.name = "Hud_Node"
        HudUI.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        HudUI.color = SKColor.clear
        HudUI.position = CGPoint(x: 0.0, y: 0.0)
        HudUI.zPosition = 10.0
        
        
        let label1Icon = SKSpriteNode(imageNamed: "Collectible_Coin")
        label1Icon.size = states.iconSize
        label1Icon.position = CGPoint(x: states.leftIconPosition, y: states.yPositionIcon)
        
        let pauseButton = SKSpriteNode(imageNamed: "Button_Pause")
        pauseButton.name = "Button_Pause"
        pauseButton.size = states.iconSize
        pauseButton.position = CGPoint(x: UIScreen.main.bounds.midX, y: states.yPositionIcon)
        
        let label2Icon = SKSpriteNode(imageNamed: "Icon_Altitude")
        label2Icon.size = states.iconSize
        label2Icon.position = CGPoint(x: states.rightIconPosition, y: states.yPositionIcon)
        
        
        
        label1.name = "Score_Node"
        label1.fontName = states.fontName
        label1.fontSize = states.labelTextSize
        label1.fontColor = states.borderColor
        label1.position = CGPoint(x: states.leftLabelPosition, y: states.yPositionLabel)
        label1.text = String(format: "%d", states.collectedCoins)
                
        label2.name = "Altitude_Node"
        label2.fontName = states.fontName
        label2.fontSize = states.labelTextSize
        label2.fontColor = states.borderColor
        label2.position = CGPoint(x: states.rightLabelPosition, y: states.yPositionLabel)
        label2.text = "\(states.convertPositionToAltitude(position: states.currentPositionY))"
        

        
        HudUI.addChild(label1)
        HudUI.addChild(label1Icon)
        HudUI.addChild(pauseButton)
        HudUI.addChild(label2)
        HudUI.addChild(label2Icon)

        return HudUI
    }
    
    func updateLabel1() {
        
        label1.text = String(format: "%d", states.collectedCoins)
    }
    
    func updateLabel2() {
        
        label2.text = "\(states.convertPositionToAltitude(position: states.currentPositionY))"
    }
    
    func updateHud() {
        
        updateLabel1()
        updateLabel2()
    }
    
}

