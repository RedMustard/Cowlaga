//
//  GameScene.swift
//  Cowlaga
//
//  Created by Travis Barnes on 2/7/16.
//  Copyright (c) 2016 Team Cowsay. All rights reserved.
//

import SpriteKit
import UIKit

struct PhysicsCategory {
    static let None       : UInt32 = 0
    static let All        : UInt32 = UInt32.max
    static let Player     : UInt32 = 1 << 0
    static let PlayProj   : UInt32 = 1 << 1
    static let Enemy      : UInt32 = 1 << 2
    static let EnemyProj  : UInt32 = 1 << 3
    static let Border     : UInt32 = 1 << 4
}


class LevelOne: SKScene, SKPhysicsContactDelegate {
    let hud = HUD()
    let player = Player()
    let basicEnemy = BasicEnemy(imageName: "basicEnemy")
    let midEnemy = MidEnemy(imageName: "midEnemy")
    let menu = InGameMenu()
    var lives = 3
    let i = 1
    
    var basicEnemyArray = [BasicEnemy]()
    var midEnemyArray = [MidEnemy]()
    var bodiesToRemove = [SKSpriteNode]()
    var shouldRemoveBodies = false
    
    
    func addPlayer() {
        print("Lives\(lives)")
        
        // Call Game Over
        if lives == 0 {
            if let view = view {
                let scene = GameOverScene(size: view.bounds.size)
                scene.scaleMode = .ResizeFill
                view.presentScene(scene)
            }
        }
            
        else {
            addChild(player)
            player.position = CGPoint(x: player.size.width, y: self.frame.height/2)
            hud.updateLives()
            hud.addLives(self, lives: lives)
        }
    }

    
    func addHud() {
        addChild(hud)
        hud.addControls(self)
        hud.addInfo(self)
        hud.addLives(self, lives: lives)
        hud.addScore(self)
    }
    
    
    func updateHud() {
        hud.removeFromParent()
        runAction(SKAction.runBlock(addHud))
    }
    
    
    func updateScore() {
        hud.updateScore()
        hud.addScore(self)
    }
    
    
    func pauseGame() {
        addChild(menu)
        menu.addMenu(self)
        scene!.paused = true
    }
    
    
    func enemyFire() {
        
        basicEnemy.fireBullet(self)
        midEnemy.fireBullet(self)
    }
    
    
    func enemyHit(enemy: MidEnemy) {
        enemy.addHit()
        score += 10
        updateScore()
        print("enemy health: \(enemy.health)")
    }
    
    
    func midEnemyDead(enemy: MidEnemy)-> Bool {
        if enemy.health == 0 {
            return true
        }
        
        return false
    }
    
    
    func addBasicEnemy(enemy: BasicEnemy) {
        let enemy = BasicEnemy(imageName: "basicEnemy")
        basicEnemyArray.append(enemy)
        enemy.addEnemy(self)
    }

    
    func addMidEnemy(enemy: MidEnemy) {
        let enemy = MidEnemy(imageName: "midEnemy")
        midEnemyArray.append(enemy)
        enemy.addEnemy(self)
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        
        // Set world physics and gravity
        scene!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x:40, y:0, width: self.frame.width, height: self.frame.height-45))
        scene!.physicsBody?.categoryBitMask = PhysicsCategory.Border
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        // Add HUD
        runAction(SKAction.runBlock(addHud))
        
        // Add Player
        runAction(SKAction.runBlock(addPlayer))
        
        // Repeatedly add 6 basic enemies at random intervals
        for i in 0...5 {
            let i = BasicEnemy(imageName: "basicEnemy")
            runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock({
                        self.addBasicEnemy(i)
                    }),
                    SKAction.waitForDuration(NSTimeInterval (random(min: 5.0, max: 10.0)))
                ])
            ))
        }
        
//        runAction(SKAction.waitForDuration(NSTimeInterval (random(min: 5.0, max: 9.0))))
        // Repeatedly add 3 basic enemies at random intervals
        for i in 0...2 {
            let i = MidEnemy(imageName: "midEnemy")
            runAction(SKAction.waitForDuration(NSTimeInterval (random(min: 5.0, max: 9.0))))
            runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock({
                        self.addMidEnemy(i)
                    }),
                    SKAction.waitForDuration(NSTimeInterval (random(min: 15.0, max: 25.0)))
                ])
            ))
        }
        
        
        // Make enemies shoot
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(enemyFire),
                SKAction.waitForDuration(0.5)
                ])
            ))
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // for each new touch on the screen
        for touch: AnyObject in touches {
            // we get the location of the touch
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node == hud.menuLabel {
                runAction(SKAction.runBlock(pauseGame))
            }
            
            if node == menu.buttonMenu {
                if let view = view {
                    createUserScores()
                    addScore(score)
                    score = 0
                    
                    let scene = MenuScene(size: view.bounds.size)
                    scene.scaleMode = .ResizeFill
                    view.presentScene(scene)
                }
            }
            
            if node == menu.buttonScores {
                if let view = view {
                    createUserScores()
                    addScore(score)
                    score = 0
                    
                    let scene = ScoreScene(size: view.bounds.size)
                    scene.scaleMode = .ResizeFill
                    view.presentScene(scene)
                }
            }
            
            if node == menu.buttonBack {
                menu.removeFromParent()
                scene!.paused = false
            }
            
            for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
                if button.containsPoint(location) && hud.pressedButtons.indexOf(button) == nil {
                    hud.pressedButtons.append(button)
                }
            }
        }
        
        for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
            if hud.pressedButtons.indexOf(button) == nil {
                button.alpha = 0.2
            } else {
                button.alpha = 0.8
            }
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesEndedOrCancelled(touches, withEvent: event)
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
    }
    
    
    ////////////////////////// DPAD + BUTTON STUFF /////////////////////////////
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // If I move off a button, I remove it from the list,
        // If I move on a button, I add it to the list
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
                // If I get off the button where my finger was before
                if button.containsPoint(previousLocation)
                    && !button.containsPoint(location) {
                        // I remove it from the list
                        let index = hud.pressedButtons.indexOf(button)
                        if index != nil {
                            hud.pressedButtons.removeAtIndex(index!)
                        }
                }
                // If I get on the button where I wasn't previously
                else if !button.containsPoint(previousLocation)
                    && button.containsPoint(location)
                    && hud.pressedButtons.indexOf(button) == nil {
                        // I add it to the list
                        hud.pressedButtons.append(button)
                }
            }
        }
        // Update transparency for all 4 buttons
        for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
            if hud.pressedButtons.indexOf(button) == nil {
                button.alpha = 0.2
            }
            else {
                button.alpha = 0.8
            }
        }
    }

    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchesEndedOrCancelled(touches, withEvent: event)
    }
    
    
    func touchesEndedOrCancelled(touches: Set<NSObject>?, withEvent event: UIEvent?) {
        for touch: AnyObject in touches! {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
                if button.containsPoint(location) {
                    let index = hud.pressedButtons.indexOf(button)
                    if index != nil {
                        hud.pressedButtons.removeAtIndex(index!)
                    }
                }
                else if (button.containsPoint(previousLocation)) {
                    let index = hud.pressedButtons.indexOf(button)
                    if index != nil {
                        hud.pressedButtons.removeAtIndex(index!)
                    }
                }
            }
        }
        
        for button in [hud.buttonDirUp, hud.buttonDirDown, hud.buttonShoot] {
            if hud.pressedButtons.indexOf(button) == nil {
                button.alpha = 0.2
            }
            else {
                button.alpha = 0.8
            }
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if hud.pressedButtons.indexOf(hud.buttonDirUp) != nil {
            player.position.y += 5.0
        }
        if hud.pressedButtons.indexOf(hud.buttonDirDown) != nil {
            player.position.y -= 5.0
        }
        if hud.pressedButtons.indexOf(hud.buttonShoot) != nil {
            player.fireBullet(self)
        }
        
        if shouldRemoveBodies == true {
            for i in 0...bodiesToRemove.count-1 {
                bodiesToRemove[i].removeFromParent()
            }
            
            bodiesToRemove.removeAll(keepCapacity: false)
            
            shouldRemoveBodies = false
        }
        
    }
    ///////////////////////////// END DPAD STUFF //////////////////////////////////
    
    
    func projectileDidCollideWithMonster(firstBody:SKSpriteNode, secondBody:SKSpriteNode) {
        print("Removed")
        
        var i = 0
        
        for index in midEnemyArray {
            if index == secondBody {
                print("index = second")
                enemyHit(secondBody as! MidEnemy)
                
                if midEnemyDead(secondBody as! MidEnemy) {
                    bodiesToRemove.append(firstBody)
                    bodiesToRemove.append(secondBody)
                    shouldRemoveBodies = true
                    
                    midEnemyArray.removeAtIndex(midEnemyArray.indexOf(index)!)
                    score += 250
                    updateScore()
                    
                } else {
                    bodiesToRemove.append(firstBody)
                    shouldRemoveBodies = true
                }

            }
            i++
        }
        
        i = 0
        
        for index in basicEnemyArray {
            if index == secondBody {
                bodiesToRemove.append(firstBody)
                bodiesToRemove.append(secondBody)
                shouldRemoveBodies = true
                basicEnemyArray.removeAtIndex(basicEnemyArray.indexOf(index)!)
                score += 100
                updateScore()
            }
            i++
        }

    
        if firstBody == player {
            bodiesToRemove.append(firstBody)
            bodiesToRemove.append(secondBody)
            shouldRemoveBodies = true
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Implement score here
        // Player hit
        if (firstBody.categoryBitMask == PhysicsCategory.Player) {
            print("player hit")
            projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode,
                secondBody: secondBody.node as! SKSpriteNode)
//            lives--
            runAction(SKAction.runBlock(addPlayer))

            if score >= 30 {
                score -= 30
                updateScore()
            
            } else {
                score = 0
                updateScore()
            }
            // Enemy hit by player projectile
        } else if (secondBody.categoryBitMask == PhysicsCategory.Enemy &&
            firstBody.categoryBitMask == PhysicsCategory.PlayProj)  {
                    print("enemy hit")
                    projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode,
                        secondBody: secondBody.node as! SKSpriteNode)
        }
    } // End didBeginContact
} // End Scene