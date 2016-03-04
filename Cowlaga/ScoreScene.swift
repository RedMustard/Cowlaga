//
//  ScoreScene.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class ScoreScene: SKScene {
    
    let backButton = SKSpriteNode(imageNamed: "play")
    let scoreTitle = SKLabelNode()
    
    func scoreList() {
        let oneScore = SKLabelNode(text: "1. \(userScores.stringForKey("1")!)")
        oneScore.position = CGPointMake(frame.width/2, frame.height - 65)
        oneScore.zPosition = 1
        oneScore.fontSize = 18
        self.addChild(oneScore)
        
        let twoScore = SKLabelNode(text: "2. \(userScores.stringForKey("2")!)")
        twoScore.position = CGPointMake(frame.width/2, frame.height - 90)
        twoScore.zPosition = 1
        twoScore.fontSize = 18
        self.addChild(twoScore)
        
        let thrScore = SKLabelNode(text: "3. \(userScores.stringForKey("3")!)")
        thrScore.position = CGPointMake(frame.width/2, frame.height - 115)
        thrScore.zPosition = 1
        thrScore.fontSize = 18
        self.addChild(thrScore)
        
        let fouScore = SKLabelNode(text: "4. \(userScores.stringForKey("4")!)")
        fouScore.position = CGPointMake(frame.width/2, frame.height - 140)
        fouScore.zPosition = 1
        fouScore.fontSize = 18
        self.addChild(fouScore)
        
        let fivScore = SKLabelNode(text: "5. \(userScores.stringForKey("5")!)")
        fivScore.position = CGPointMake(frame.width/2, frame.height - 165)
        fivScore.zPosition = 1
        fivScore.fontSize = 18
        self.addChild(fivScore)
        
        let sixScore = SKLabelNode(text: "6. \(userScores.stringForKey("6")!)")
        sixScore.position = CGPointMake(frame.width/2, frame.height - 190)
        sixScore.zPosition = 1
        sixScore.fontSize = 18
        self.addChild(sixScore)
        
        let sevScore = SKLabelNode(text: "7. \(userScores.stringForKey("7")!)")
        sevScore.position = CGPointMake(frame.width/2, frame.height - 215)
        sevScore.zPosition = 1
        sevScore.fontSize = 18
        self.addChild(sevScore)
        
        let eigScore = SKLabelNode(text: "8. \(userScores.stringForKey("8")!)")
        eigScore.position = CGPointMake(frame.width/2, frame.height - 240)
        eigScore.zPosition = 1
        eigScore.fontSize = 18
        self.addChild(eigScore)
        
        let ninScore = SKLabelNode(text: "9. \(userScores.stringForKey("9")!)")
        ninScore.position = CGPointMake(frame.width/2, frame.height - 265)
        ninScore.zPosition = 1
        ninScore.fontSize = 18
        self.addChild(ninScore)
        
        let tenScore = SKLabelNode(text: "10. \(userScores.stringForKey("10")!)")
        tenScore.position = CGPointMake(frame.width/2, frame.height - 290)
        tenScore.zPosition = 1
        tenScore.fontSize = 18
        self.addChild(tenScore)
        
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
        
        backButton.position = CGPointMake(frame.width/2, frame.height/8)
        self.addChild(backButton)
        backButton.zPosition = 1
        
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
        }
    } // End touchesBegan
} // End class