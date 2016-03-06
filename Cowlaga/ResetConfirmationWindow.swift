//
//  ResetConfirmationWindow.swift
//  Cowlaga
//
//  Created by Travis Barnes on 3/6/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class ResetConfirmationWindow: SKSpriteNode {
    let buttonOkay = SKSpriteNode(imageNamed: "okay_button")
    let buttonCancel = SKSpriteNode(imageNamed: "cancel_button")
    let confirmationLabel = SKLabelNode(text: "Are you sure you want to reset the high scores?")
    
    init() {
        let texture = SKTexture(imageNamed: "menubox")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.size = CGSize(width: 400, height: 220)
        self.position = CGPoint(x: 330, y: 135)
        self.zPosition = 2
        self.alpha = 1.5
        
        addMenu()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addMenu() {
        confirmationLabel.position = CGPoint(x: self.size.width/2 - 200 , y: self.size.height/2 - 45)
        confirmationLabel.zPosition = 3
        confirmationLabel.fontSize = 18
        confirmationLabel.alpha = 2
        self.addChild(confirmationLabel)
        
        
        buttonOkay.position = CGPoint(x: self.size.width/2 - 200, y: self.size.height/2 - 100)
        buttonOkay.zPosition = 3
        buttonOkay.setScale(1)
        buttonOkay.alpha = 2
        self.addChild(buttonOkay)
        
        buttonCancel.position = CGPoint(x: self.size.width/2 - 200, y: self.size.height/2 - 155)
        buttonCancel.zPosition = 3
        buttonCancel.setScale(1)
        buttonCancel.alpha = 2
        self.addChild(buttonCancel)
        
    }
}

