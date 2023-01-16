//
//  RunnerSprite.swift
//  touchbar
//
//  Created by David Garcia on 4/5/22.
//

import SpriteKit


class RunnerSprite: Sprite {
    
    // constants:
    let numActions: Int = 4 // based off of number of case statements in state variable below
    
    init() {
        let fileName: String    = "runner.png"
        let widths: [CGFloat]   = [CGFloat(157), CGFloat(238), CGFloat(187), CGFloat(162)]
        let heights: [CGFloat]  = [CGFloat(223), CGFloat(177), CGFloat(198), CGFloat(204)]
        let numFrames: [Int]    = [6, 2, 1, 6]
        
        
        super.init(
            aspectRatio: 1.0,
            speedDir: 700,
            spriteLoader: SpriteLoader(
                fileName: fileName, widths: widths, heights: heights, numFrames: numFrames, numActions: self.numActions
            )
        )
    }
    
    override var state: State {
        didSet {
            switch self.state {
                // Y values are based on SpriteSheets/skeleton.png
                // t values are based on what looks most appealing
            case .right:    self.aspectRatio = abs(self.aspectRatio)
            case .left:     self.aspectRatio = -abs(self.aspectRatio)
            default:        break
            }
            let params = self.getActionParameters(state: self.state)
            self.performActions(params: params)
        }
    }
    override func getActionParameters(state: State) -> actionParameters {
        switch state {
        case .jump:     return [(3, 0.15), (0, 0.15)];
        case .slide:    return [(2, 6.5)];
        case .fall:     return [(1, 0.25), (0, 0)];
        case .right:    return [(0, 0.15)];
        case .left:     return [(0, 0.15)];
            
        default: fatalError()
        }
    }
    
    
    override func otherState(_ state: State) -> State {
        switch state {
        case .jump:
            if self.aspectRatio > 0 {
                return .right
            }; return .left
        case .slide:
            if self.aspectRatio > 0 {
                return .left
            }; return .right
            
        case .fall:
            if self.aspectRatio > 0 {
                return .right
            }; return .left
        case .right:    return .slide
        case .left:     return .slide
        default:
            return state
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
