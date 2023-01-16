//
//  Canvas.swift
//  touchbar
//
//  Created by David Garcia on 3/30/22.
//

import Cocoa
import SpriteKit


var sceneDict: [String: Scene] = [
    "Space": SpaceScene(),
    "Runner": RunnerScene(),
    "TwitchDog": TwitchDogScene(),
    "Snowman": SnowmanScene(),
]


class Canvas: SKView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if menu_scene == nil {
            menu_scene = SnowmanScene()
        }
        presentScene(menu_scene)
        
    }
    
    override func touchesBegan(with event: NSEvent) {
        scene?.touchesBegan(with: event)
    }
    
    override func touchesMoved(with event: NSEvent) {
        scene?.touchesMoved(with: event)
    }
    
    override func touchesEnded(with event: NSEvent) {
        scene?.touchesEnded(with: event)
    }
    
}
