//
//  ViewController.swift
//  oop-game-2
//
//  Created by Cody Condon on 2016-04-13.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var player1AttackBtn: UIButton!
    @IBOutlet weak var player2AttackBtn: UIButton!
    @IBOutlet weak var player1HpLbl: UILabel!
    @IBOutlet weak var player2HpLbl: UILabel!
    @IBOutlet weak var chestBtn: UIButton!
   
    var player1: Player1!
    var player2: Player2!
    var chestMessage: String?
    var btnSound: AVAudioPlayer!
    var treasureSound: AVAudioPlayer!
    var trollSound: AVAudioPlayer!
    var knightSound: AVAudioPlayer!
    var medievalBgMusic: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //SOUND EFFECTS
       
        //ATTACK SOUND EFFECT
        let path = NSBundle.mainBundle().pathForResource("sword2", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // TREASURE SOUND EFFECT
        let path2 = NSBundle.mainBundle().pathForResource("treasure", ofType: "mp3")
        let soundUrl2 = NSURL(fileURLWithPath: path2!)
        do {
            try treasureSound = AVAudioPlayer(contentsOfURL: soundUrl2)
            treasureSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // DEFEATION TROLL SOUND EFFECT
        let path3 = NSBundle.mainBundle().pathForResource("troll", ofType: "mp3")
        let soundUrl3 = NSURL(fileURLWithPath: path3!)
        do {
            try trollSound = AVAudioPlayer(contentsOfURL: soundUrl3)
            trollSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // DEFEATION KNIGHT SOUND EFFECT 
        let path4 = NSBundle.mainBundle().pathForResource("knight", ofType: "mp3")
        let soundUrl4 = NSURL(fileURLWithPath: path4!)
        do {
            try knightSound = AVAudioPlayer(contentsOfURL: soundUrl4)
            knightSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        // BACKGROUND MUSIC 
        let path5 = NSBundle.mainBundle().pathForResource("medievalBgMusic", ofType: "mp3")
        let soundUrl5 = NSURL(fileURLWithPath: path5!)
        do {
            try medievalBgMusic = AVAudioPlayer(contentsOfURL: soundUrl5)
            medievalBgMusic.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
        
        player1 = Player1(name: "Dorky Troll", hp: 100, attackPwr: 10)
        player2 = Player2(name: "Wild Knight", hp: 100, attackPwr: 10)
        
        generatePlayer1()
        generatePlayer2()
        medievalBgMusic.play()
        
        player1HpLbl.text = "\(player1.hp) HP"
        player2HpLbl.text = "\(player2.hp) HP"
    }


   
    @IBAction func onChestTapped(sender: AnyObject) {
        treasureSound.play()
        chestBtn.hidden = true
        mainLbl.text = chestMessage
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.generatePlayer2), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.generatePlayer1), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.newGameText), userInfo: nil, repeats: false)
    }
    
    @IBAction func player1AttackTapped(sender: AnyObject) {
        if player1.attemptAttack(player2.attackPwr) {
            btnSound.play()
            player1AttackBtn.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.enablePlayer1), userInfo: nil, repeats: false)
            mainLbl.text = "Attacked \(player1.type) for \(player2.attackPwr) HP"
            player1HpLbl.text = "\(player1.hp) HP"
            
        } else {
            mainLbl.text = "Attack was unsuccessful"
        }
        
        if let loot = player1.dropLoot() {
            player2.addItemToInventory(loot)
            chestMessage = "\(player2.type) found \(loot)"
            chestBtn.hidden = false
        }
        
        if !player1.isAlive {
            trollSound.play()
            mainLbl.text = "Killed \(player1.type)"
            player1Img.hidden = true
            player1HpLbl.text = ""
        }
    }
    
    @IBAction func player2AttackTapped(sender: AnyObject) {
        if player2.attemptAttack(player1.attackPwr) {
             btnSound.play()
            player2AttackBtn.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.enablePlayer2), userInfo: nil, repeats: false)
            mainLbl.text = "Attacked \(player2.type) for \(player1.attackPwr) HP"
            player2HpLbl.text = "\(player2.hp) HP"
        } else {
            mainLbl.text = "Attack was unsuccessful"
        }
        if let loot = player2.dropLoot() {
            player1.addItemToInventory(loot)
            chestMessage = "\(player1.type) found \(loot)"
            chestBtn.hidden = false
        }
        if !player2.isAlive {
            knightSound.play()
            mainLbl.text = "Killed \(player2.type)"
            player2Img.hidden = true
            player2HpLbl.text = ""
        }
    }
    
    func generatePlayer1() {
        player1 = Player1(startingHp: 100, attackPwr:10 )
        player1HpLbl.text = "\(player1.hp) HP"
        player1Img.hidden = false
    }
    func generatePlayer2() {
        player2 = Player2(startingHp: 100, attackPwr: 10)
        player2HpLbl.text = "\(player2.hp) HP"
        player2Img.hidden = false
    }
    func newGameText() {
        mainLbl.text = "NEW GAME"
    }
    func enablePlayer1() {
        player1AttackBtn.enabled = true
    }
    func enablePlayer2() {
        player2AttackBtn.enabled = true
    }
}

