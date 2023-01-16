//
//  TwitchDogSprite.swift
//  touchbar
//
//  Created by David Garcia on 4/13/22.
//

import SpriteKit


class TwitchDogSprite: Sprite {
    
    // constants:
    let numActions: Int = 3 // based off of number of case statements in state variable below
    
    init() {
        let fileName: String    = "twitchdog.png"
        let widths: [CGFloat]   = [CGFloat(116), CGFloat(136), CGFloat(144)]
        let heights: [CGFloat]  = [CGFloat(160), CGFloat(160), CGFloat(160)]
        let numFrames: [Int]    = [15, 9, 9]
        
        super.init(
            aspectRatio: 1.0,
            speedDir: 0,
            spriteLoader: SpriteLoader(
                fileName: fileName, widths: widths, heights: heights, numFrames: numFrames, numActions: self.numActions
            ),
            state: State.idle
        )
    }
    
    override func getActionParameters(state: State) -> actionParameters {
        var params: actionParameters
        switch state {
            // values are based on SpriteSheets/filename & what looks most appealing
        case .sleep:    params = [(2, 0.20)];
        case .awake:    params = [(1, 0.35), (0, 0.15)];
        case .idle:     params = [(0, 0.15)];
        default: fatalError()
        }
        return params
    }
    
    override func otherState(_ state: State) -> State {
        switch state {
        case .sleep:    return .awake
        case .awake:    return .idle
        case .idle:     return .sleep
        default:
            print("case not covered")
            return state
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
