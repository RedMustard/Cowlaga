//
//  Player.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit


class Player: SKSpriteNode {
    var canFire = true
    
    
    init() {
        let texture = SKTexture(imageNamed: "Spaceship")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width, height: self.size.height - 20))
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.EnemyProj
        self.physicsBody?.collisionBitMask = PhysicsCategory.Border
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false

        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fireBullet(scene: SKScene) {
        if (!canFire) {
            return
        } else {
            canFire = false
            let projectile = PlayerBullet(imageName: "projectile")
            projectile.position.x = self.position.x + 40
            projectile.position.y = self.position.y
            scene.addChild(projectile)
            
            let moveBulletAction = SKAction.moveTo(CGPoint(x: scene.size.width + projectile.size.width, y: self.position.y), duration: 1.0)
            let removeBulletAction = SKAction.removeFromParent()
            
            projectile.runAction(SKAction.sequence([moveBulletAction, removeBulletAction]))
            
            let waitToEnableFire = SKAction.waitForDuration(0.25)
            runAction(waitToEnableFire, completion: {
                self.canFire = true
            })
        }
    }
}