//
//  TemplateScene.swift
//  touchbar
//
//  Created by David Garcia on 4/5/22.
//

import SpriteKit

class TemplateScene: Scene, SceneChild {
    
    init() {
        super.init(backgroundFile: "")
    }
    
    override func getSprite() -> Sprite {
        return TemplateSprite()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
