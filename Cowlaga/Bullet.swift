//
//  Bullet.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/25/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

class Bullet: SKSpriteNode {
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}