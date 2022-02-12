//
//  ContactCategories.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import Foundation

struct ContactCategories {
    static let NodeRemoverCategory     : UInt32 = 0x1 << 0
    static let PlayerCategory          : UInt32 = 0x1 << 1
    static let PlatformCategory        : UInt32 = 0x1 << 2
    static let CollectibleCategory     : UInt32 = 0x1 << 3
    static let ObstacleCategory        : UInt32 = 0x1 << 4
    static let GroundCategory          : UInt32 = 0x1 << 5
    static let CatapultCategory        : UInt32 = 0x1 << 6
}

