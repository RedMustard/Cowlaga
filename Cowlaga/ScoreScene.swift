//
//  ScoreScene.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class ScoreScene: SKScene {
    let backButton = SKSpriteNode(imageNamed: "menu_button")
    let resetButton = SKSpriteNode(imageNamed: "reset_button")
    let scoreTitle = SKLabelNode()
    let confirm = ResetConfirmationWindow()
    
    
    let oneScore = SKLabelNode()
    let twoScore = SKLabelNode()
    let thrScore = SKLabelNode()
    let fouScore = SKLabelNode()
    let fivScore = SKLabelNode()
    let sixScore = SKLabelNode()
    let sevScore = SKLabelNode()
    let eigScore = SKLabelNode()
    let ninScore = SKLabelNode()
    let tenScore = SKLabelNode()
    
    
    func scoreList() {
        oneScore.text = "1.  \(userScores.stringForKey("1")!)"
        oneScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        oneScore.position = CGPointMake(frame.width/2 - 120, frame.height - 75)
        oneScore.zPosition = 1
        oneScore.fontSize = 22
        self.addChild(oneScore)
        
        twoScore.text = "2.  \(userScores.stringForKey("2")!)"
        twoScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        twoScore.position = CGPointMake(frame.width/2 - 120, frame.height - 110)
        twoScore.zPosition = 1
        twoScore.fontSize = 22
        self.addChild(twoScore)
        
        thrScore.text = "3.  \(userScores.stringForKey("3")!)"
        thrScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        thrScore.position = CGPointMake(frame.width/2 - 120, frame.height - 145)
        thrScore.zPosition = 1
        thrScore.fontSize = 22
        self.addChild(thrScore)
        
        fouScore.text = "4.  \(userScores.stringForKey("4")!)"
        fouScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        fouScore.position = CGPointMake(frame.width/2 - 120, frame.height - 180)
        fouScore.zPosition = 1
        fouScore.fontSize = 22
        self.addChild(fouScore)
        
        fivScore.text = "5.  \(userScores.stringForKey("5")!)"
        fivScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        fivScore.position = CGPointMake(frame.width/2 - 120, frame.height - 215)
        fivScore.zPosition = 1
        fivScore.fontSize = 22
        self.addChild(fivScore)
        
        sixScore.text = "6.  \(userScores.stringForKey("6")!)"
        sixScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        sixScore.position = CGPointMake(frame.width/2 + 45, frame.height - 75)
        sixScore.zPosition = 1
        sixScore.fontSize = 22
        self.addChild(sixScore)
        
        sevScore.text = "7.  \(userScores.stringForKey("7")!)"
        sevScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        sevScore.position = CGPointMake(frame.width/2 + 45, frame.height - 110)
        sevScore.zPosition = 1
        sevScore.fontSize = 22
        self.addChild(sevScore)
        
        eigScore.text = "8.  \(userScores.stringForKey("8")!)"
        eigScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        eigScore.position = CGPointMake(frame.width/2 + 45, frame.height - 145)
        eigScore.zPosition = 1
        eigScore.fontSize = 22
        self.addChild(eigScore)
        
        ninScore.text = "9.  \(userScores.stringForKey("9")!)"
        ninScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        ninScore.position = CGPointMake(frame.width/2 + 45, frame.height - 180)
        ninScore.zPosition = 1
        ninScore.fontSize = 22
        self.addChild(ninScore)
        
        tenScore.text = "10.  \(userScores.stringForKey("10")!)"
        tenScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        tenScore.position = CGPointMake(frame.width/2 + 35, frame.height - 215)
        tenScore.zPosition = 1
        tenScore.fontSize = 22
        self.addChild(tenScore)
        
    } // End scoreList
    
    func removeScoreList() {
        oneScore.removeFromParent()
        twoScore.removeFromParent()
        thrScore.removeFromParent()
        fouScore.removeFromParent()
        fivScore.removeFromParent()
        sixScore.removeFromParent()
        sevScore.removeFromParent()
        eigScore.removeFromParent()
        ninScore.removeFromParent()
        tenScore.removeFromParent()
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        let bgImage = SKSpriteNode(imageNamed: "bg")
        bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(bgImage)
        bgImage.zPosition = 0
        
        scoreTitle.text = "Top 10 Scores:"
        scoreTitle.position = CGPointMake(frame.width/2, frame.height-40)
        self.addChild(scoreTitle)
        scoreTitle.zPosition = 1
        
        scoreList()
        
        backButton.position = CGPointMake(frame.width/2, frame.height/2 - 80)
        self.addChild(backButton)
        backButton.zPosition = 1
        
        resetButton.position = CGPointMake(frame.width/2, frame.height/2 - 135)
        self.addChild(resetButton)
        resetButton.zPosition = 1
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // for each new touch on the screen
        for touch: AnyObject in touches {
            // we get the location of the touch
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == backButton {
                if let view = view {
                    let scene = MenuScene(size: view.bounds.size)
                    scene.scaleMode = .ResizeFill
                    view.presentScene(scene)
                }
            }
            
            if node == resetButton {
                self.addChild(confirm)
            }
            
            if node == confirm.buttonCancel {
                confirm.removeFromParent()
            }
            
            if node == confirm.buttonOkay {
                confirm.removeFromParent()
                scoreFlag = true
                initUserScores()
                removeScoreList()
                scoreList()
            }
        }
    } // End touchesBegan
    
    
} // End class