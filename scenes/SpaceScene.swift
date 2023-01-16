//
//  SpaceScene.swift
//  touchbar
//
//  Created by David Garcia on 4/5/22.
//

import SpriteKit

class SpaceScene: Scene, SceneChild {
    
    init() {
        super.init(backgroundFile: "space.jpg", gravityVector: CGVector.init(dx: 0, dy: 0))
    }
    
    override func getSprite() -> Sprite {
        let s: Sprite
        
        switch CGFloat.random(in: 0...1) {
        case 0.0...0.5:     s = SkeletonSprite()
        case 0.5...1.0:     s = SkeletonSprite()
        default:            fatalError()
        }
        return s
    }
    
    
    override func customDidBegin(_ left: Sprite, _ right: Sprite) {
        // walking in the same direction
        if left.state == right.state {
            if Bool.random() {
                left.toggleState()
            }
            else { right.toggleState() }
        }
        // if they're heading in differing directions, then flip both of them
        else {
            left.toggleState()
            right.toggleState()
        }
        
        left.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
        left.physicsBody?.applyAngularImpulse(0.0005)
        
        right.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
        right.physicsBody?.applyAngularImpulse(-0.0005)
        
    }
    
    override func customTouchesBegan(_ location: CGPoint) {
        // nothing to do here
    }
    
    override func customTouchesMoved(_ location: CGPoint) {
        if let sprite = self.spriteAt(point: location) {
            sprite.position = location
        }
    }
    
    override func customTouchesEnded(_ location: CGPoint) {
        if let sprite = self.spriteAt(point: location) {
            sprite.toggleState()
        }
        else {
            self.addSprite(at: location)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
