//
//  CoordinateSystem.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation
import SpriteKit

struct CoordinateSystem {
    
    let rowAmount: Int
    let columnAmount: Int
    let lastRow: CGFloat
    
    func createCoordinates() -> [CGFloat: [CGFloat]] {
        
        let screenWidth = Int(UIScreen.main.bounds.width)
        let columnWidth = screenWidth / columnAmount
        let columnHeight = Int(Double(columnWidth) / 1.3)
        let columnCenter = columnWidth / 2
        var columnPositions = [CGFloat]()
        var rowPosition = lastRow + CGFloat(columnHeight + (columnHeight / 3))
        var coordinates = [CGFloat: [CGFloat]]()
        
        for column in 1...columnAmount {

            let columnPosition = CGFloat((Int(columnWidth) * column) - Int(columnCenter))
            
            columnPositions.append(columnPosition)
            
        }

        for _ in 1...rowAmount {
            
            coordinates[rowPosition] = columnPositions
            
            rowPosition += CGFloat(columnHeight + (columnHeight / 3))
            
        }
        
        return coordinates
        
    }
}

