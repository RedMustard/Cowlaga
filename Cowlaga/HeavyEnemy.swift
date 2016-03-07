//
//  HrdEnemy.swift
//  Cowlaga
//
//  Created by Travis Barnes on 3/6/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class HeavyEnemy: Enemy {
    private var canFire = true
    var health = 10
    
    override init(imageName: String) {
        super.init(imageName: imageName)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayProj|PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fireBullet(scene: SKScene) {
        if (!canFire) {
            return
        } else {
            canFire = false
            let projectile = EnemyBullet(imageName: "hvyEnemyProjectile")
            let projectile2 = EnemyBullet(imageName: "hvyEnemyProjectile")
            let projectile3 = EnemyBullet(imageName: "hvyEnemyProjectile")
            let projectile4 = EnemyBullet(imageName: "hvyEnemyProjectile")
            
            projectile.position.x = self.position.x
            projectile.position.y = self.position.y + 55
            
            projectile2.position.x = self.position.x
            projectile2.position.y = self.position.y - 55
            
            projectile3.position.x = self.position.x - 50
            projectile3.position.y = self.position.y + 15

            projectile4.position.x = self.position.x - 50
            projectile4.position.y = self.position.y - 15

            scene.addChild(projectile)
            scene.addChild(projectile2)
            scene.addChild(projectile3)
            scene.addChild(projectile4)
            
            let moveBulletAction1 = SKAction.moveTo(CGPoint(x: -scene.size.width + projectile.size.width, y: self.position.y+42), duration: 2.5)
            let moveBulletAction2 = SKAction.moveTo(CGPoint(x: -scene.size.width + projectile.size.width, y: self.position.y-42), duration: 2.5)
            let moveBulletAction3 = SKAction.moveTo(CGPoint(x: -scene.size.width + projectile.size.width, y: self.position.y+15), duration: 2.0)
            let moveBulletAction4 = SKAction.moveTo(CGPoint(x: -scene.size.width + projectile.size.width, y: self.position.y-15), duration: 2.0)
            
            let removeBulletAction = SKAction.removeFromParent()
            
            projectile.runAction(SKAction.sequence([moveBulletAction1, removeBulletAction]))
            projectile2.runAction(SKAction.sequence([moveBulletAction2, removeBulletAction]))
            projectile3.runAction(SKAction.sequence([moveBulletAction3, removeBulletAction]))
            projectile4.runAction(SKAction.sequence([moveBulletAction4, removeBulletAction]))
            
            let waitToEnableFire = SKAction.waitForDuration(NSTimeInterval (random(min: CGFloat(1.25), max: CGFloat(3.0))))
            runAction(waitToEnableFire, completion: {
                self.canFire = true
            })
        }
    }
    
    
    func addHit() {
        health--
    }
    
    
    private func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    private func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func addEnemy(scene: SKScene) {
        // Determine where to spawn the enemy along the Y axis
        let actualY = random(min: self.size.height/2, max: scene.size.height-45 - self.size.height/2)
        
        // Position the enemy slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        self.position = CGPoint(x: scene.size.width + self.size.width/2, y: actualY)
        
        // Add the enemy to the scene
        scene.addChild(self)
        
        // Determine speed of the enemy
        let actualDuration = random(min: CGFloat(10.0), max: CGFloat(15.0))
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -self.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        self.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
}