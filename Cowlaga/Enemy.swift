//
//  Enemy.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/25/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit
import UIKit

// TODO:
// -- NEEDS TO SHOOT
// -- ENEMY HIT COUNT (PLAY AROUND FOR DIFFICULT)
// -- PLAY WITH SPEEDS TO INCREASE DIFFICULTY
// -- WILL HAVE INFINITE LOOP LEFT TO RIGHT OF SCREEN, UNTIL DEAD
// -- BASIC ENEMY SCORE: 10/HIT, 100/KILL -- 1 HIT
// -- MID ENEMY SCORE: 10/HIT, 250/KILL -- 2 HITS
// -- BOSS ENEMY SCORE: 5/HIT, 1000/KILL -- 50 HITS
// -- WHEN ENEMY DIES, SHOOT 4 PROJECTILES IN NESW DIRECTIONS WHICH DAMAGE ENEMIES/PLAYER



class Enemy: SKSpriteNode {
    private var canFire = true
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    init(imageName: String) {
//        let texture = SKTexture(imageNamed: imageName)
//        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
//        
//        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // 1
//        self.physicsBody?.dynamic = true // 2
//        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
//        self.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
//        
////        self.runAction(fireBullet)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    func fireBullet(scene: SKScene) {
//        if (!canFire) {
//            return
//        } else {
//            canFire = false
//            let projectile = PlayerBullet(imageName: "projectile")
//            projectile.position.x = self.position.x + self.size.width/2
//            projectile.position.y = self.position.y
//            scene.addChild(projectile)
//            
//            let moveBulletAction = SKAction.moveTo(CGPoint(x: scene.size.width + projectile.size.width, y: self.position.y), duration: 1.0)
//            let removeBulletAction = SKAction.removeFromParent()
//            
//            projectile.runAction(SKAction.sequence([moveBulletAction, removeBulletAction]))
//            
//            let waitToEnableFire = SKAction.waitForDuration(0.3)
//            runAction(waitToEnableFire, completion: {
//                self.canFire = true
//            })
//        }
//    }
}