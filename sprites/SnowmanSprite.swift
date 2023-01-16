//
//  SnowmanSprite.swift
//  touchbar
//
//  Created by David Garcia on 4/13/22.
//

import SpriteKit


class SnowmanSprite: Sprite {
    
    // constants:
    let numActions: Int = 20 // based off of number of case statements in state variable below
    
    init() {
        let fileName: String    = "snowman.png"
        let widths: [CGFloat]   = [CGFloat(129), CGFloat(102), CGFloat(85), CGFloat(47), CGFloat(37), CGFloat(33), CGFloat(34), CGFloat(33), CGFloat(66), CGFloat(44), CGFloat(36), CGFloat(65), CGFloat(48), CGFloat(40), CGFloat(43), CGFloat(46), CGFloat(66), CGFloat(43), CGFloat(33), CGFloat(34)]
        let heights: [CGFloat]  = [CGFloat(134), CGFloat(67), CGFloat(43), CGFloat(48), CGFloat(39), CGFloat(41), CGFloat(44), CGFloat(42), CGFloat(42), CGFloat(42), CGFloat(42), CGFloat(43), CGFloat(42), CGFloat(40), CGFloat(46), CGFloat(34), CGFloat(32), CGFloat(50), CGFloat(42), CGFloat(42)]
        let numFrames: [Int]    = [6, 13, 4, 1, 4, 1, 4, 2, 4, 2, 9, 4, 4, 8, 2, 2, 4, 7, 4, 4]
        
        super.init(
            aspectRatio: 1,
            speedDir: 1 * (CGFloat.random(in: 0...9) + 1),
            spriteLoader: SpriteLoader(
                fileName: fileName, widths: widths, heights: heights, numFrames: numFrames, numActions: self.numActions, noSpace: true
            ),
            state: State.explode
        )
    }
    
    override func getActionParameters(state: State) -> actionParameters {
        var params: actionParameters
        switch state {
            // values are based on SpriteSheets/filename & what looks most appealing
        case .idle:         params = [(19, 0.20)];
        case .blink:        params = [(18, 0.35)];
        case .left:         params = [(17, 0.15)];
        case .right:        params = [(17, 0.15)];
        case .sleep:        params = [(16, 0.15)];
        case .lounge:       params = [(15, 0.15)];
        case .freakout:     params = [(14, 0.15)];
        case .scared:       params = [(13, 0.15)];
        case .simp:         params = [(12, 0.15)];
        case .angry:        params = [(11, 0.15)];
        case .confused:     params = [(10, 0.15)];
        case .realize:      params = [(09, 0.15)];
        case .cry:          params = [(08, 0.15)];
        case .peace:        params = [(07, 0.15)];
        case .embarassed:   params = [(06, 0.15)];
        case .back:         params = [(05, 0.15)];
        case .melt:         params = [(04, 0.15)];
        case .wink:         params = [(03, 0.25)];
        case .love:         params = [(02, 0.15)];
        case .explode:      params = [(01, 0.20), (00, 0.20), (17, 0.15)];
        default: fatalError()
        }
        return params
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
