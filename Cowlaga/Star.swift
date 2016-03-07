//
//  Star.swift
//  Cowlaga
//
//  Created by Travis Barnes on 3/6/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class Star: Enemy {
//    private var canFire = true
    
    
    override init(imageName: String) {
        super.init(imageName: imageName)
        
//        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
//        self.physicsBody?.dynamic = true
//        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayProj|PhysicsCategory.Player
//        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    func fireBullet(scene: SKScene) {
//        if (!canFire) {
//            return
//        } else {
//            canFire = false
//            let projectile = EnemyBullet(imageName: "basicEnemyProjectile")
//            projectile.position.x = self.position.x
//            projectile.position.y = self.position.y
//            scene.addChild(projectile)
//            
//            let moveBulletAction = SKAction.moveTo(CGPoint(x: -scene.size.width + projectile.size.width, y: self.position.y), duration: 2.0)
//            let removeBulletAction = SKAction.removeFromParent()
//            
//            projectile.runAction(SKAction.sequence([moveBulletAction, removeBulletAction]))
//            
//            let waitToEnableFire = SKAction.waitForDuration(NSTimeInterval (random(min: 0.7, max: 2.0)))
//            runAction(waitToEnableFire, completion: {
//                self.canFire = true
//            })
//        }
//    }
    
    
    private func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    private func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func addStar(scene: SKScene) {
        // Determine where to spawn the enemy along the Y axis
        let actualY = random(min: self.size.height/2, max: scene.size.height-30 - self.size.height/2)
        
        // Position the enemy slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        self.position = CGPoint(x: scene.size.width + self.size.width/2, y: actualY)
        self.zPosition = -1
        
        // Add the enemy to the scene
        scene.addChild(self)
        
        // Determine speed of the enemy
        let actualDuration = random(min: CGFloat(0.5), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -self.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        self.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
}

