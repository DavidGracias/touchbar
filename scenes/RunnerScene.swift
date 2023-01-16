//
//  RunnerScene.swift
//  touchbar
//
//  Created by David Garcia on 4/5/22.
//

import SpriteKit

class RunnerScene: Scene, SceneChild {
    
    var jumpTime: TimeInterval?
    var slideTime: TimeInterval?
    var shouldFall = false
    let distFromEdge: Double = 125
    
    init() {
        super.init(backgroundFile: "field.jpg", gravityVector: CGVector.init(dx: 0, dy: -1.45))
    }
    
    override func getSprite() -> Sprite {
        return RunnerSprite()
    }
    
    
    override func customDidBegin(_ spriteA: Sprite, _ spriteB: Sprite) {
        // collision
    }
    
    override func customTouchesBegan(_ location: CGPoint) {
        if let sprite = self.spriteAt(point: location) {
            if sprite.position.x <= touchbarWidth {
                if sprite.state == State.left || sprite.state == State.right {
                    sprite.state = State.jump
                    self.jumpTime = NSDate().timeIntervalSince1970
                }
                else if sprite.state == State.jump {
                    self.shouldFall = true
                }
            }
        }
    }
    
    override func customTouchesMoved(_ location: CGPoint) {
        // nothing to do here
    }
    
    override func customTouchesEnded(_ location: CGPoint) {
        if sprites.count < 1 {
            self.addSprite(at: location)
        }
        // start
    }
    
    override func customUpdate(_ currentTime: TimeInterval) {
        if sprites.count == 1 {
            let sprite: Sprite = sprites[0]
            
            // reset jump
            if let jt = self.jumpTime, sprite.state == State.jump && (NSDate().timeIntervalSince1970 - jt) >= 0.85 {
                self.jumpTime = nil
                if self.shouldFall {
                    sprite.state = State.fall
                }
                else {
                    sprite.toggleState()
                }
            }
            
            // initiate slide
            if  (sprite.state == State.right && abs(touchbarWidth - sprite.position.x) <= self.distFromEdge) ||
                (sprite.state == State.left && abs(0 - sprite.position.x) <= self.distFromEdge)
            {
                sprite.toggleState()
                self.slideTime = currentTime
            }
            
            // reset slide
            if let st = self.slideTime, sprite.state == State.slide && (currentTime - st) >= 0.85 {
                self.slideTime = nil
                sprite.toggleState()
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
