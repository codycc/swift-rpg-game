//
//  Player2.swift
//  oop-game-2
//
//  Created by Cody Condon on 2016-04-13.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation

class Player2: Player {
    override var loot: [String] {
        return ["Silver Sword", "Shiny Helmet", "Chain Wristguard"]
    }
    
    override var type: String {
        return "Knight"
    }
}