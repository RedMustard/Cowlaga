//
//  File.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    let playButton = SKSpriteNode(imageNamed: "play")
    let scoreButton = SKSpriteNode(imageNamed: "play")
    let gameTitle = SKLabelNode()
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        let bgImage = SKSpriteNode(imageNamed: "bg")
        bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(bgImage)
        bgImage.zPosition = 0
        
        gameTitle.text = "Cowlaga"
        gameTitle.position = CGPointMake(frame.width/2, frame.height-75)
        self.addChild(gameTitle)
        gameTitle.zPosition = 1
        
        playButton.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(playButton)
        playButton.zPosition = 1
        
        scoreButton.position = CGPointMake(frame.width/2, frame.height/2-75)
        self.addChild(scoreButton)
        scoreButton.zPosition = 1
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // for each new touch on the screen
        for touch: AnyObject in touches {
            // we get the location of the touch
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == playButton {
                if let view = view {
                    let scene = GameScene(size: view.bounds.size)
                    scene.scaleMode = .ResizeFill
                    view.presentScene(scene)
                }
                
            } else if node == scoreButton {
                if let view = view {
                    let scene = ScoreScene(size: view.bounds.size)
                    scene.scaleMode = .ResizeFill
                    view.presentScene(scene)
                }

            } 
        }
    } // End touchesBegan
} // End class