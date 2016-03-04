//
//  File.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit


class GameOverScene: SKScene {
    let backButton = SKSpriteNode(imageNamed: "play")
    let gameOverLabel = SKLabelNode(text: "Game Over.")
    let scoreLabel = SKLabelNode(text: "Your score: \(score)")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        
        gameOverLabel.position = CGPointMake(frame.width/2, frame.height-75)
        self.addChild(gameOverLabel)
        
        backButton.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(backButton)
        
        scoreLabel.position = CGPointMake(frame.width/2, frame.height-125)
        self.addChild(scoreLabel)
        
        createUserScores()
        addScore(score)
        
        score = 0
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