//
//  DefaultButton.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct DefaultButton {

    var id: String
    var position: CGPoint
    var text: String
    
    func build() -> SKShapeNode {
        
        let size = states.buttonSize
        let myPosition = CGPoint(x: (position.x - size.width/2), y: (position.y - size.height/2))
        
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: myPosition.x, y: myPosition.y, width: size.width, height: size.height), cornerWidth: 15, cornerHeight: 15)
        shape.name = id
        shape.path = path
        shape.lineWidth = 3
        shape.zPosition = 1
        shape.fillColor = states.backgroundColor
        shape.strokeColor = states.borderColor
        
        let label = SKLabelNode()
        label.name = id
        label.text = text
        label.position = CGPoint(x: shape.frame.midX, y: shape.frame.midY)
        label.verticalAlignmentMode = .center
        label.fontSize = states.buttonTextSize
        label.color = states.textColor
        label.fontName = states.fontName
        
        shape.addChild(label)
        
        return shape
    }
}

