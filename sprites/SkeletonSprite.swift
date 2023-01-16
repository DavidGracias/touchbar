//
//  SkeletonSprite.swift
//  touchbar
//
//  Created by David Garcia on 3/29/22.
//

import SpriteKit


class SkeletonSprite: Sprite {
    
    // constants:
    let numActions: Int = 4 // based off of number of case statements in state variable below
    
    init() {
        let fileName: String    = "skeleton.png"
        let width: CGFloat      = CGFloat(29)
        let height: CGFloat     = CGFloat(45.5)
        let numFrames: Int      = 9
        
        super.init(
            aspectRatio: 1.0,
            speedDir: 110.0 * (CGFloat.random(in: 0...9) + 1),
            spriteLoader: SpriteLoader(
                fileName: fileName, width: width, height: height, numFrames: numFrames, numActions: self.numActions
            ),
            state: Bool.random() ? State.left : State.right
        )
    }
    
    
    override func getActionParameters(state: State) -> actionParameters {
        var params: actionParameters
        switch state {
            // Y values are based on SpriteSheets/skeleton.png
            // t values are based on what looks most appealing
        case .up:    params = [(3, 0.15)];
        case .left:  params = [(2, 0.15)];
        case .down:  params = [(1, 0.15)];
        case .right: params = [(0, 0.15)];
        default: fatalError()
        }
        return params
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
