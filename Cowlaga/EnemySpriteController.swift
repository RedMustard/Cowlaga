//
//  EnemySpriteController.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/24/16.
//  Copyright © 2016 Team Cowsay. All rights reserved.
//

import SpriteKit

// Controller class for:
// - creating/destroying enemies,
// - shooting
// - animitaions
class EnemySpriteController {
    var enemySprites: [SKSpriteNode] = []
    
    // Return a new enemy sprite which follows the targetSprite node
    func spawnEnemy(targetSprite: SKNode) -> SKSpriteNode {
        
        // create a new enemy sprite
        let newEnemy = SKSpriteNode(imageNamed:"Spaceship")
        enemySprites.append(newEnemy)
        newEnemy.xScale = 0.08
        newEnemy.yScale = 0.08
        newEnemy.color = UIColor.redColor()
        newEnemy.colorBlendFactor=0.4
        
        // position new sprite at a random position on the screen
        let sizeRect = UIScreen.mainScreen().applicationFrame;
        let posX = arc4random_uniform(UInt32(sizeRect.size.width))
        let posY = arc4random_uniform(UInt32(sizeRect.size.height))
        newEnemy.position = CGPoint(x: CGFloat(posX), y: CGFloat(posY))
        
        // Define Constraints for orientation/targeting behavior
        let i = enemySprites.count-1
        let rangeForOrientation = SKRange(constantValue:CGFloat(M_2_PI*7))
        let orientConstraint = SKConstraint.orientToNode(targetSprite, offset: rangeForOrientation)
        let rangeToSprite = SKRange(lowerLimit: 80, upperLimit: 90)
        var distanceConstraint: SKConstraint
        
        // First enemy has to follow spriteToFollow, second enemy has to follow first enemy, ...
        if enemySprites.count-1 == 0 {
            distanceConstraint = SKConstraint.distance(rangeToSprite, toNode: targetSprite)
        } else {
            distanceConstraint = SKConstraint.distance(rangeToSprite, toNode: enemySprites[i-1])
        }
        newEnemy.constraints = [orientConstraint, distanceConstraint]
        
        return newEnemy
        
    }
    
}