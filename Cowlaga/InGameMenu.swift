//
//  InGameMenu.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/29/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class InGameMenu: SKSpriteNode {
    let buttonMenu = SKSpriteNode(imageNamed: "menu_button")
    let buttonScores = SKSpriteNode(imageNamed: "score_button")
    let buttonRestart = SKSpriteNode(imageNamed: "restart_button")
    let buttonBack = SKSpriteNode(imageNamed: "back_button")
    let buttonGod = SKShapeNode(circleOfRadius: 10)
    let width = 1350
    let height = 750


    init() {
        let texture = SKTexture(imageNamed: "menubox")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.size = CGSize(width: self.width, height: self.height)
        self.position = CGPoint(x: 0, y: 0)
        self.zPosition = 2
        self.alpha = 0.7
        
        addMenu()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addMenu() {
        let pauseLabel = SKLabelNode(text: "Game Paused")
        pauseLabel.position = CGPoint(x: self.size.width/4 - 4, y: self.size.height/2 - 90)
        pauseLabel.alpha = 2
        pauseLabel.zPosition = 3
        self.addChild(pauseLabel)
        
        buttonMenu.position = CGPoint(x: self.size.width/4 - 4, y: self.size.height/2 - 160)
        buttonMenu.zPosition = 3
        buttonMenu.setScale(1)
        buttonMenu.alpha = 2
        self.addChild(buttonMenu)

        buttonScores.position = CGPoint(x: self.size.width/4 - 4, y: self.size.height/2 - 215)
        buttonScores.zPosition = 3
        buttonScores.setScale(1)
        buttonScores.alpha = 2
        self.addChild(buttonScores)
        
        buttonRestart.position = CGPoint(x: self.size.width/4 - 4, y: self.size.height/2 - 270)
        buttonRestart.zPosition = 3
        buttonRestart.setScale(1)
        buttonRestart.alpha = 2
        self.addChild(buttonRestart)
        
        buttonBack.position = CGPoint(x: self.size.width/4 - 4, y: self.size.height/2 - 325)
        buttonBack.zPosition = 3
        buttonBack.setScale(1)
        buttonBack.alpha = 2
        self.addChild(buttonBack)
        
        let labelGod = SKLabelNode(text: "God Mode")
        labelGod.position = CGPoint(x: self.size.width/2 - 60, y: self.size.height/2 - 85)
        labelGod.zPosition = 3
        labelGod.fontSize = 18
        labelGod.alpha = 2
        self.addChild(labelGod)
        
        buttonGod.position = CGPoint(x: self.size.width/2 - 60, y: self.size.height/2 - 50)
        buttonGod.zPosition = 3
        buttonGod.fillColor = SKColor.whiteColor()
        buttonGod.alpha = 2
        self.addChild(buttonGod)
    }
}
