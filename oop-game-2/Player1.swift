//
//  Player1.swift
//  oop-game-2
//
//  Created by Cody Condon on 2016-04-13.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation

class Player1: Player {
    override var loot: [String] {
        return ["Spikey Dagger","Bronze Coins","Rusty Necklace"]
    }
    
    override var type: String {
        return "Troll"
    }
    
    
}