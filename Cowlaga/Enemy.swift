//
//  Enemy.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/25/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit
import UIKit

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
}