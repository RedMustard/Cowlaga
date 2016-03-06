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


class GameScene: SKScene, SKPhysicsContactDelegate {
    let hud = HUD()
    let player = Player()
    let menu = InGameMenu()
    let confirm = ConfirmationWindow()
    var lives = 3
    
    var basicEnemyArray = [BasicEnemy]()    // Hold all alive basic enemies
    var midEnemyArray = [MidEnemy]()        // Hold all alive mid enemies
    var bodiesToRemove = [SKSpriteNode]()   // Hold all dead enemies waiting to be removed
    var shouldRemoveBodies = false          // Flag to determine if there are enemies waiting to be removed
    
    var prevNodeMenu = false                // Flag for confirmation window
    var prevNodeScore = false               // Flag for confirmation window
    var prevNodeRestart = false             // Flag for confirmation window

    
    func addPlayer() {
        // If no more lives, call Game Over
        if lives <= 0 {
            if let view = view {
                let scene = GameOverScene(size: view.bounds.size)
                scene.scaleMode = .ResizeFill
                view.presentScene(scene)
            }
        }
        // Else respawn player
        else {
            addChild(player)
            player.position = CGPoint(x: player.size.width, y: self.frame.height/2)
            runAction(SKAction.sequence([
                SKAction.runBlock(playerGodMode),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOff),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOn),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOff),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOn),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOff),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOn),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(blinkOff),
                SKAction.waitForDuration(0.5),
                SKAction.runBlock(playerNormalMode),
                ]))
            hud.updateLives()
            hud.addLives(self, lives: lives)
        }
    }

    
    func blinkOn() {
        player.alpha = 0.5
    }
    
    
    func blinkOff() {
        player.alpha = 0
    }
    
    
    func playerGodMode() {
        player.physicsBody?.categoryBitMask = PhysicsCategory.None
        player.alpha = 0.5
    }
    
    
    func playerNormalMode() {
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.alpha = 1
    }
    
    
    func addHud() {
        addChild(hud)
        hud.addControls(self)
        hud.addInfo(self)
        hud.addLives(self, lives: lives)
        hud.addScore(self)
    }
    
    
    func updateScore() {
        hud.updateScore()
        hud.addScore(self)
    }
    
    
    func pauseGame() {
        addChild(menu)
//        menu.addMenu(self)
        scene!.paused = true
    }
    
    func openConfirm() {
        menu.addChild(confirm)
    }
    
    
    func enemyFire() {
        for enemy in basicEnemyArray {
            enemy.fireBullet(self)
        }
        for enemy in midEnemyArray {
            enemy.fireBullet(self)
        }
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
    
    func midFire(enemy: MidEnemy) {
        enemy.fireBullet(self)
    }
    
    func addEnemyActions() {
        // Add basic level enemies after 2-10 seconds. Repeatedly spawn every 5-10 seconds
        for _ in 0...7 {
            let i = BasicEnemy(imageName: "basicEnemy")
            runAction(SKAction.waitForDuration(NSTimeInterval (random(min: 2.0, max: 10.0))))
            runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.waitForDuration(NSTimeInterval (random(min: 5.0, max: 10.0))),
                    SKAction.runBlock({
                        self.addBasicEnemy(i)
                    })
                    ])
                ))
        }
        
        // Add mid level enemies after 45-75 seconds. Repeatedly spawn every 10-20 seconds
        for _ in 0...2 {
            let i = MidEnemy(imageName: "midEnemy")
            runAction(SKAction.sequence([
                SKAction.waitForDuration(NSTimeInterval (random(min: 45.0, max: 75.0))),
                SKAction.repeatActionForever(
                    SKAction.sequence([
                        SKAction.waitForDuration(NSTimeInterval (random(min: 10.0, max: 20.0))),
                        SKAction.runBlock({
                            self.addMidEnemy(i)
                        })
                    ])
                )
            ]))
        }

    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        let bgImage = SKSpriteNode(imageNamed: "bg")
        bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        bgImage.zPosition = -1
        self.addChild(bgImage)
        
        // Set world physics and gravity
        scene!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x:40, y:0, width: self.frame.width, height: self.frame.height-30))
        scene!.physicsBody?.categoryBitMask = PhysicsCategory.Border
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        // Add HUD
        runAction(SKAction.runBlock(addHud))
        
        // Add Player
        runAction(SKAction.runBlock(addPlayer))
        
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.runBlock(addEnemyActions)
            ])
        )
        
        // Make enemies shoot
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(enemyFire),
                SKAction.waitForDuration(0.5)
                ])
            ))
    } // End didMoveToView
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // for each new touch on the screen
        for touch: AnyObject in touches {
            // we get the location of the touch
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            // IN-GAME MENU BUTTONS
            if node == hud.menuLabel {
                runAction(SKAction.runBlock(pauseGame))
            }
            
            if node == menu.buttonMenu {
                openConfirm()
                prevNodeMenu = true
            }
            
            if node == confirm.buttonCancel {
                confirm.removeFromParent()
            }
            
            if node == confirm.buttonOkay {
                if prevNodeMenu == true {
                    if let view = view {
                        prevNodeMenu = false
                        initUserScores()
                        addScore(score)
                        score = 0
                        
                        let scene = MenuScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        view.presentScene(scene)
                    }
                } else if prevNodeScore == true {
                    if let view = view {
                        prevNodeScore = false
                        initUserScores()
                        addScore(score)
                        score = 0
                    
                        let scene = ScoreScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        view.presentScene(scene)
                    }
                    
                } else if prevNodeRestart == true {
                    if let view = view {
                        prevNodeRestart = false
                        initUserScores()
                        addScore(score)
                        score = 0
                    
                        let scene = GameScene(size: view.bounds.size)
                        scene.scaleMode = .ResizeFill
                        view.presentScene(scene)
                    }
                }
            }
            
            if node == menu.buttonScores {
                openConfirm()
                prevNodeScore = true
            }
            
            if node == menu.buttonRestart {
                openConfirm()
                prevNodeRestart = true
            }
            
            if node == menu.buttonBack {
                menu.removeFromParent()
                scene!.paused = false
            }
            // END IN-GAME MENU BUTTONS
            
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
    } // End touchesBegan
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesEndedOrCancelled(touches, withEvent: event)
        
        let touch = touches.first
        let _ = touch!.locationInNode(self)
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
        
        // If collision flag raised, remove flagged bodies
        if shouldRemoveBodies == true {
            for i in 0...bodiesToRemove.count-1 {
                bodiesToRemove[i].removeFromParent()
                
                if bodiesToRemove[i] == player {
                    print("body is player")
                    addPlayer()
                }

            }
            
            bodiesToRemove.removeAll(keepCapacity: false)
            
            shouldRemoveBodies = false
        }
        
    }
    ///////////////////////////// END DPAD STUFF //////////////////////////////////
    
    
    func projectileDidCollideWithMonster(firstBody:SKSpriteNode, secondBody:SKSpriteNode) {
        print("Removed")
        
        // If midEnemy is hit
        var i = 0
        for index in midEnemyArray {
            if index == secondBody {
                print("index = second")
                enemyHit(secondBody as! MidEnemy)
                updateScore()
                
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
        
        // If basicEnemy is hit
        i = 0
        for index in basicEnemyArray {
            if index == secondBody {
                bodiesToRemove.append(firstBody)
                bodiesToRemove.append(secondBody)
                shouldRemoveBodies = true
                basicEnemyArray.removeAtIndex(basicEnemyArray.indexOf(index)!)
                score += 110
                updateScore()
            }
            i++
        }
        
        // If player is hit
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
            lives--

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