//
//  MenuUI.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct MenuUI {
    
    var headerText = ""
    var labelText1 = ""
    var labelText2 = ""
    var menuUIState = ""
    var button1Text = ""
    
    let MenuUI = SKSpriteNode()
    
    mutating func build() -> SKSpriteNode {
        
        MenuUI.color = SKColor.black
        MenuUI.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        MenuUI.position = CGPoint(x: 0.0, y: 0.0)
        MenuUI.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        MenuUI.alpha = 0.6
        MenuUI.zPosition = 20
        MenuUI.name = "menuUI"
        
        if menuUIState == "StartMenu" {
            
            headerText = "Balloon Jumper"
            labelText1 = "Highest Altitude: \(states.convertPositionToAltitude(position: states.highscorePositionY))"
            labelText2 = "Coins Collected: \(states.coinbank)"
            button1Text = "Play"
                        
        } else if menuUIState == "PauseMenu" {
            
            headerText = "Game Paused!"
            labelText1 = "Current Altitude: \(states.convertPositionToAltitude(position: states.currentPositionY))"
            labelText2 = "Coins Collected: \(states.collectedCoins)"
            button1Text = "New Game"
            
            let continueButton = DefaultButton(
                id: "Button_Continue",
                position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + 80),
                text: "Continue"
            ).build()
            MenuUI.addChild(continueButton)
            
        } else if menuUIState == "GameOverMenu" {
            
            headerText = "Game Over!"
            labelText1 = "Highest Altitude this Round: \(states.convertPositionToAltitude(position: states.highestPositionY))"
            labelText2 = "Coins Collected: \(states.collectedCoins)"
            button1Text = "Play Again"
        }
        
        let title = SKLabelNode(fontNamed: states.fontName)
        title.text = headerText
        title.fontSize = states.titleTextSize
        title.name = "headerTitle"
        title.fontColor = states.textColor
        title.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 150)
        MenuUI.addChild(title)
        
        let label1 = SKLabelNode(fontNamed: states.fontName)
        label1.text = labelText1
        label1.fontSize = states.labelTextSize
        label1.name = "Highscore"
        label1.fontColor = states.textColor
        label1.zPosition = 21
        label1.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        MenuUI.addChild(label1)
        
        let label2 = SKLabelNode(fontNamed: states.fontName)
        label2.text = labelText2
        label2.fontSize = states.labelTextSize
        label2.name = "Highscore"
        label2.fontColor = states.textColor
        label2.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 50)
        MenuUI.addChild(label2)
        
        let startButton = DefaultButton(
            id: "Button_NewGame",
            position: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + states.buttonSize.height + 100),
            text: button1Text
        ).build()
        MenuUI.addChild(startButton)

        return MenuUI
    }
    
    mutating func updateMenuData(state: String) {
 
        menuUIState = state
        
    }
}

