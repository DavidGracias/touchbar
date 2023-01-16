//
//  SpriteLoader.swift
//  touchbar
//
//  Created by David Garcia on 3/29/22.
//

import SpriteKit

class SpriteLoader {
    
    let SpriteSheet: SKTexture
    
    let widths: [CGFloat]
    let heights: [CGFloat]
    let xSpace: [CGFloat]
    let ySpace: CGFloat
    let numFrames: [Int]
    let numActions: Int
    
    // sprite with all the same width and height and equal frames
    convenience init(fileName: String, width: CGFloat, height: CGFloat, numFrames: Int, numActions: Int) {
        self.init(
            fileName:   fileName,
            widths:     Array(repeating: width,     count: numActions),
            heights:    Array(repeating: height,    count: numActions),
            numFrames:  Array(repeating: numFrames, count: numActions),
            numActions: numActions
        )
    }
    
    // sprite with all the same width and height, but different frame numbers (per action)
    convenience init(fileName: String, width: CGFloat, height: CGFloat, numFrames: [Int], numActions: Int) {
        self.init(
            fileName:   fileName,
            widths:     Array(repeating: width, count: numActions),
            heights:    Array(repeating: height, count: numActions),
            numFrames:  numFrames, numActions: numActions
        )
    }
    
    
    init(fileName: String, widths: [CGFloat], heights: [CGFloat], numFrames: [Int], numActions: Int, noSpace: Bool = false) {
        self.widths = widths
        self.heights = heights
        self.numFrames = numFrames
        self.numActions = numActions
        self.SpriteSheet = SKTexture(imageNamed: fileName)
        
        let size = self.SpriteSheet.size()
        var ySpace: CGFloat = 0
        if !noSpace {
            ySpace = size.height
            for i in 0..<self.numActions {
                ySpace -= heights[i]
            }
            if self.numActions > 1 {
                ySpace = ySpace/CGFloat(self.numActions-1)
            }
        }
        self.ySpace = ySpace
        
        var spacing = [CGFloat]()
        for i in 0..<self.numActions {
            var xSpace: CGFloat = 0
            if !noSpace {
                xSpace = size.width - CGFloat(self.numFrames[i]) * self.widths[i]
                if self.numFrames[i] > 1 {
                    xSpace = xSpace/CGFloat(self.numFrames[i]-1)
                }
            }
            spacing.append( xSpace )
        }
        self.xSpace = spacing
    }
    
    func getTexture() -> SKTexture{ return self.SpriteSheet }
    
    func getMaxSize() -> CGSize{
        return CGSize(width: self.widths.max()!, height: self.heights.max()!)
    }
    
    func getPhysicsBody(_ Y: Int) -> SKPhysicsBody{
        return SKPhysicsBody(rectangleOf: CGSize(width: self.widths[Y], height: self.heights[Y]))
    }
    func getCurrentSize(_ Y: Int, _ aspectRatio: Double) -> CGSize{
        let physicalWidth = self.widths[Y]/self.heights[Y]*(touchbarHeight * abs(aspectRatio))
        let physicalHeight = touchbarHeight * abs(aspectRatio)
        
        return CGSize(width: physicalWidth, height: physicalHeight)
    }
    func getCurrentSize(_ Y: Int) -> CGSize{
        let physicalWidth = self.widths[Y]
        let physicalHeight = self.heights[Y]
        
        return CGSize(width: physicalWidth, height: physicalHeight)
    }
    
    
    func getAnimation(_ Y: Int) -> [SKTexture] {
        let size = self.getTexture().size()
        
        let width  = self.widths[Y]  / size.width
        let height = self.heights[Y] / size.height
        
        var textures: [SKTexture] = []
        
        var y: CGFloat = 0
        if Y > 0 {
            for i in 1...Y {
                y += (self.heights[i-1] + ySpace)
            }
        }
        for i in 0..<self.numFrames[Y] {
            let x = CGFloat(i)*(self.widths[Y]  + self.xSpace[Y])
            let curRect = CGRect(
                x: x/size.width, y: y/size.height, width: width, height: height
            )
            textures.append(SKTexture(rect: curRect, in: self.getTexture()))
        }
        return textures
    }
}
