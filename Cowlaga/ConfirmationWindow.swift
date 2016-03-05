//
//  ConfirmationWindow.swift
//  Cowlaga
//
//  Created by Travis Barnes on 3/5/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class ConfirmationWindow: SKSpriteNode {
    let buttonOkay = SKSpriteNode(imageNamed: "okay_button")
    let buttonCancel = SKSpriteNode(imageNamed: "cancel_button")
    let confirmationLabel = SKLabelNode(text: "Are you sure you want to end the current game?")
    
    init() {
        let texture = SKTexture(imageNamed: "menubox")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.size = CGSize(width: 400, height: 200)
        self.position = CGPoint(x: 335, y: 140)
        self.zPosition = 2
        self.alpha = 1.5
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addMenu(scene: SKScene) {
        confirmationLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        confirmationLabel.zPosition = 3
        confirmationLabel.setScale(1)
        confirmationLabel.alpha = 2
        self.addChild(confirmationLabel)
        
        
        buttonOkay.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        buttonOkay.zPosition = 3
        buttonOkay.setScale(1)
        buttonOkay.alpha = 2
        self.addChild(buttonOkay)
        
        buttonCancel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        buttonCancel.zPosition = 3
        buttonCancel.setScale(1)
        buttonCancel.alpha = 2
        self.addChild(buttonCancel)
        
    }
}
