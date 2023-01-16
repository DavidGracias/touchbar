//
//  SnowmanScene.swift
//  touchbar
//
//  Created by David Garcia on 4/13/22.
//

import SpriteKit

class SnowmanScene: Scene, SceneChild {
    
    init() {
        super.init(backgroundFile: "space.jpg")
    }
    
    override func getSprite() -> Sprite {
        return SnowmanSprite()
    }
    
    
    override func customDidBegin(_ left: Sprite, _ right: Sprite) {
        // add code here...
        sprites[0].toggleState()
    }
    
    override func customTouchesBegan(_ location: CGPoint) {
        // add code here...
    }
    
    override func customTouchesMoved(_ location: CGPoint) {
        // add code here...
    }
    
    override func customTouchesEnded(_ location: CGPoint) {
        // add code here...
    }
    
    override func customUpdate(_ currentTime: TimeInterval) {
        // add code here...
        
        if sprites.count < 1 {
            addSprite(at: CGPoint(x: frame.midX, y: spriteSpawnY) )
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
