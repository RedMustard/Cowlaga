//
//  InGameMenu.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/29/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class InGameMenu: SKSpriteNode {
    let buttonBack = SKSpriteNode(imageNamed: "play")
    let buttonMenu = SKSpriteNode(imageNamed: "play")
    let buttonScores = SKSpriteNode(imageNamed: "play")
    
    
    init() {
        let texture = SKTexture(imageNamed: "menubox")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.size = CGSize(width: 1350, height: 700)
        self.position = CGPoint(x: 0, y: 0)
        self.zPosition = 1
        self.alpha = 0.7
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addMenu(scene: SKScene) {
        let pauseLabel = SKLabelNode(text: "Game Paused")
        pauseLabel.position = CGPoint(x: self.size.width/4 - 8, y: self.size.height/2 - 60)
        pauseLabel.alpha = 2
        pauseLabel.zPosition = 1
        self.addChild(pauseLabel)
        
        buttonMenu.position = CGPoint(x: self.size.width/4 - 8, y: self.size.height/2 - 125)
        buttonMenu.zPosition = 1
        buttonMenu.setScale(1)
        buttonMenu.alpha = 2
        self.addChild(buttonMenu)

        buttonScores.position = CGPoint(x: self.size.width/4 - 8, y: self.size.height/2 - 175)
        buttonScores.zPosition = 1
        buttonScores.setScale(1)
        buttonScores.alpha = 2
        self.addChild(buttonScores)
        
        buttonBack.position = CGPoint(x: self.size.width/4 - 8, y: self.size.height/2 - 275)
        buttonBack.zPosition = 1
        buttonBack.setScale(1)
        buttonBack.alpha = 2
        self.addChild(buttonBack)
    }
}
