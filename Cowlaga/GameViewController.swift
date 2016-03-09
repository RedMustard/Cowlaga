//
//  GameViewController.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/7/16.
//  Copyright (c) 2016 Team Cowsay. All rights reserved.
//

import UIKit
import SpriteKit

var score = IntegerLiteralType()
var scoreFlag = false
var godFlag = false
let userScores = NSUserDefaults.standardUserDefaults()


func initUserScores() {
    print("Create User Scores")
    if userScores.objectForKey("10") == nil || scoreFlag == true {
        userScores.setInteger(0, forKey: "1")
        userScores.setInteger(0, forKey: "2")
        userScores.setInteger(0, forKey: "3")
        userScores.setInteger(0, forKey: "4")
        userScores.setInteger(0, forKey: "5")
        userScores.setInteger(0, forKey: "6")
        userScores.setInteger(0, forKey: "7")
        userScores.setInteger(0, forKey: "8")
        userScores.setInteger(0, forKey: "9")
        userScores.setInteger(0, forKey: "10")
        scoreFlag = false
    }
}


func addScore(inScore: IntegerLiteralType) {
    print("Score added")
    
    for i in 1...10 {
        if inScore > userScores.integerForKey("\(i)") {
            let oldScore = userScores.integerForKey("\(i)")
            userScores.setInteger(inScore, forKey: "\(i)")
            
            addScore(oldScore)
            
            break
        }
    }
}


class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuScene = MenuScene(size: view.bounds.size) // Main Menu
//        let scene = GameScene(size: view.bounds.size) // Base Scene
        
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        menuScene.scaleMode = .ResizeFill
        skView.multipleTouchEnabled = true
        skView.presentScene(menuScene) // Show main menu
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}