//
//  File.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit


struct States {
    
    let backgroundColor = HexColorToUIColor().convertHexColor(hexColor: "1A1A1A")
    let borderColor = HexColorToUIColor().convertHexColor(hexColor: "4A4A4A")
    let textColor = HexColorToUIColor().convertHexColor(hexColor: "E0E0E0")
    let fontName = "Avenir-black"
    

    
    // DYNAMIC TEXT SIZES
    let titleTextSize = (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.030
    let labelTextSize = (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015
    let buttonTextSize = (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015
    
    // DYNAMIC BUTTON SIZES
    let buttonSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.2, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.06)
   
    // DYNAMIC POSITIONS - ICONS
    let iconSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023)
    let yPositionIcon = UIScreen.main.bounds.maxY - (((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023) * 2)
    let yPositionLabel = UIScreen.main.bounds.maxY - (((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023) * 2.3)
    let leftIconPosition = UIScreen.main.bounds.minX + ((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023)
    let leftLabelPosition = UIScreen.main.bounds.minX + (((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023) * 2)
    let rightIconPosition = UIScreen.main.bounds.maxX - (((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023) * 2)
    let rightLabelPosition = UIScreen.main.bounds.maxX - ((UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.023)
    
    // DYNAMIC ASSET SIZES.
    let collectibleSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015)
    let obstacleSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.060, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.060)
    let playerSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.040, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.045)
    let platform1Size = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.050, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.070)
    let platform2Size = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.060, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015)
    let catapultSize = CGSize(width: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.080, height: (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.020)
    
    // DYNAMIC WORLD PHYSICS.
    let dynamicGravity = (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.015
    let dynamicAccelerometer = (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.8
    
    

    
    
    

    var collectedCoins = 0
    var coinbank = UserDefaults.standard.integer(forKey: "coinbank")
    
    var currentPositionY = 0 // Realtime
    var highestPositionY = 0 // Session
    var highscorePositionY = UserDefaults.standard.integer(forKey: "highscorePosition") // Alltime
    
    
    func transformSizes(brøkdel: CGSize) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width + UIScreen.main.bounds.height
        let width = screenSize * brøkdel.width
        let height = screenSize * brøkdel.height
        
        return CGSize(width: width, height: height)
    }
    
    
    func convertPositionToAltitude(position: Int) -> Int {
        return position / 100
    }
    
    mutating func updateScore() {
        
        collectedCoins += 1
        
    }
    
    mutating func saveGame() {
        
        if highestPositionY > highscorePositionY {
            UserDefaults.standard.set(highestPositionY, forKey: "highscorePosition")
            UserDefaults.standard.synchronize()
        }

        coinbank += collectedCoins
        UserDefaults.standard.set(coinbank, forKey: "coinbank")
        UserDefaults.standard.synchronize()
        
    }
    
    func deleteSave() {
        
        UserDefaults.standard.removeObject(forKey: "coinbank")
        UserDefaults.standard.removeObject(forKey: "highscorePosition")
        UserDefaults.standard.synchronize()
        
    }
}

var states = States()

