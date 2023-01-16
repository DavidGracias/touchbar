//
//  TemplateSprite.swift
//  touchbar
//
//  Created by David Garcia on 4/5/22.
//

import SpriteKit


class TemplateSprite: Sprite {
    
    // constants:
    let numActions: Int = 4 // based off of number of case statements in state variable below
    
    init() {
        let fileName: String    = ""
        let widths: [CGFloat]   = [CGFloat(1)]
        let heights: [CGFloat]  = [CGFloat(1)]
        let numFrames: [Int]    = [1]
        
        super.init(
            aspectRatio: 1.0,
            speedDir: 1 * (CGFloat.random(in: 0...9) + 1),
            spriteLoader: SpriteLoader(
                fileName: fileName, widths: widths, heights: heights, numFrames: numFrames, numActions: self.numActions
            ),
            state: State.start
        )
    }
    
    override func getActionParameters(state: State) -> actionParameters {
        var params: actionParameters
        switch state {
            // values are based on SpriteSheets/filename & what looks most appealing
        case .right:    params = [(3, 0.15)];
        case .left:     params = [(2, 0.15)];
        case .up:       params = [(1, 0.15)];
        case .down:     params = [(0, 0.15)];
        default: fatalError()
        }
        return params
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
