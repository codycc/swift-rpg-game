//
//  Player.swift
//  oop-game-2
//
//  Created by Cody Condon on 2016-04-13.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation

class Player: Character {
    private var _name = "Player1"
    
    var loot: [String] {
        return ["Default1","Default2","Default3"]
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var type: String {
        return "Default Type"
    }
    
    private var _inventory = [String]()
    
    var inventory: [String] {
  
        return _inventory
      
    }
    
    func addItemToInventory(item: String) {
        _inventory.append(item)
    }
    
    convenience init (name: String, hp:Int, attackPwr: Int) {
        self.init(startingHp: hp, attackPwr: attackPwr)
        _name = name
    }
    
    func dropLoot() -> String? {
        if !isAlive {
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            return loot[rand]
        }
        return nil
    }
}
