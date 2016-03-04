//
//  HUD.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/25/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class HUD: SKSpriteNode {
    let buttonShoot = SKSpriteNode(imageNamed: "button_shoot")
    let buttonDirUp = SKSpriteNode(imageNamed: "button_dir_up")
    let buttonDirDown = SKSpriteNode(imageNamed: "button_dir_down")
    var pressedButtons = [SKSpriteNode]()
    
    let menuLabel = SKLabelNode(text: "Menu")
    var lifeLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()

    
    init() {
        let texture = SKTexture(imageNamed: "menubar")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.position = CGPoint(x: 0, y: 363)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addControls(scene: SKScene) {
        buttonDirUp.position = CGPoint(x: 50, y: 110)
        buttonDirUp.setScale(2.0)
        buttonDirUp.alpha = 0.2
        scene.addChild(buttonDirUp)
    
        buttonDirDown.position = CGPoint(x: 50, y: 50)
        buttonDirDown.setScale(2.0)
        buttonDirDown.alpha = 0.2
        scene.addChild(buttonDirDown)
    
        buttonShoot.position = CGPoint(x: scene.size.width - 50, y: 50)
        buttonShoot.setScale(1.5)
        buttonShoot.alpha = 0.2
        scene.addChild(buttonShoot)
    }
    
    
    func addInfo(scene: SKScene) {
        menuLabel.fontColor = SKColor.whiteColor()
        menuLabel.fontSize = 14
        menuLabel.position = CGPoint(x: scene.size.width-50, y: scene.size.height-18)
        menuLabel.zPosition = 1
        scene.addChild(menuLabel)
        

    }
    
    
    func addScore(scene: SKScene) {
        scoreLabel.text = ("Score: \(score)")
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.fontSize = 14
        scoreLabel.position = CGPoint(x: scene.size.width/2, y: scene.size.height-18)
        scoreLabel.zPosition = 1
        scene.addChild(scoreLabel)

    }
    
    
    func addLives(scene: SKScene, lives: IntegerLiteralType) {
        lifeLabel.text = "Lives: \(lives)"
        lifeLabel.fontColor = SKColor.whiteColor()
        lifeLabel.fontSize = 14
        lifeLabel.position = CGPoint(x: 30, y: scene.size.height-18)
        lifeLabel.zPosition = 1
        scene.addChild(lifeLabel)
    }
    
    
    func updateLives() {
        lifeLabel.removeFromParent()
    }
    
    
    func updateScore() {
        scoreLabel.removeFromParent()
    }
}