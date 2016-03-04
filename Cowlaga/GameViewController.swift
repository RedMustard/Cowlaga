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
//    userScores.setInteger(score, forKey: "score")
    print("Score added")
    
    for i in 1...10 {
        if inScore > userScores.integerForKey("\(i)") {
            print("true")
        }
    }
    
    
//    if userScores.integerForKey(i) < inScore {
////        if userScores.integerForKey("1") < inScore
//        userScores.setInteger(score, forKey: "1")
//    } else if userScores.integerForKey("2") == 0 {
//    
//    }
//    
}

//var scoreArray = NSMutableArray(capacity: 10)

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
//        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


//extension SKNode {
//    class func unarchiveFromFile(file : String) -> SKNode? {
//        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
//            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
//            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
//            
//            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
//            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
//            archiver.finishDecoding()
//            return scene
//        } else {
//            return nil
//        }
//    }
//}
//
//class GameViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
//            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .AspectFill
//            
//            skView.presentScene(scene)
//        }
//    }
//
//    override func shouldAutorotate() -> Bool {
//        return true
//    }
//
//    override func supportedInterfaceOrientations() -> Int {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
//        } else {
//            return Int(UIInterfaceOrientationMask.All.rawValue)
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
//
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//}
