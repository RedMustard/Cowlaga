//
//  GameViewController.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/7/16.
//  Copyright (c) 2016 Team Cowsay. All rights reserved.
//

import UIKit
import SpriteKit

let userScores = NSUserDefaults.standardUserDefaults()

func createUserScores() {
    print("createUserScores")
    if userScores.objectForKey("10") == nil {
        print("init userScore")
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


var score = IntegerLiteralType()

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuScene = MenuScene(size: view.bounds.size) // Main Menu
//        let scene = GameScene(size: view.bounds.size) // Base Scene
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        menuScene.scaleMode = .ResizeFill
        skView.multipleTouchEnabled = true
        skView.presentScene(menuScene) // Show main menu
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
