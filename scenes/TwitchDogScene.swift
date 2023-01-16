//
//  TwitchDogScene.swift
//  touchbar
//
//  Created by David Garcia on 4/13/22.
//

import SpriteKit

class TwitchDogScene: Scene, SceneChild {
    
    init() {
        super.init(backgroundFile: "field.jpg")
    }
    
    override func getSprite() -> Sprite {
        return TwitchDogSprite()
    }
    
    
    override func customDidBegin(_ left: Sprite, _ right: Sprite) {
        // add code here...
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
        else if CGFloat.random(in: 0...1) < 0.001 {
            sprites[0].toggleState()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
