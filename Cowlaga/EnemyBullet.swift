//
//  EnemyBullet.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class EnemyBullet: Bullet {
    override init(imageName: String) {
        super.init(imageName: imageName)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.EnemyProj
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}