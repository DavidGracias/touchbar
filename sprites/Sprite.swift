//
//  Sprite.swift
//  touchbar
//
//  Created by David Garcia on 3/29/22.
//

import SpriteKit

typealias actionParameters = [(Int, TimeInterval)]

enum State {
    case left
    case right
    case up
    case down
    
    case jump
    case fall
    case slide
    
    case idle
    case sleep
    case awake
    
    case blink
    case lounge
    case freakout
    case scared
    case simp
    case angry
    case confused
    case realize
    case cry
    case peace
    case embarassed
    case back
    case melt
    case wink
    case love
    case explode
    // more here...
    
    static var start = State.right
    
    var bitMask: UInt32 { get{
        switch self {
            //            case .left:     return 0x1
            //            case .right:    return 0x1
            //            case .up:       return 0x1
            //            case .down:     return 0x1
            //
            //            case .jump:     return 0x1
            //            case .fall:     return 0x1
            //            case .slide:    return 0x1
            //
        default:        return 0x1
        }
    } }
}

class Sprite : SKSpriteNode {
    
    // constants:
    var spriteLoader: SpriteLoader
    var aspectRatio: Double
    var speedDir: CGFloat
    
    var state: State {
        didSet {
            let params = self.getActionParameters(state: self.state)
            self.performActions(params: params)
        }
    }
    
    
    init(aspectRatio: Double, speedDir: CGFloat, spriteLoader: SpriteLoader, state: State = State.start){
        self.aspectRatio = aspectRatio
        self.speedDir = speedDir
        self.spriteLoader = spriteLoader
        self.state = state
        
        super.init(
            texture: self.spriteLoader.getTexture(),
            color: NSColor.clear,
            size: self.spriteLoader.getCurrentSize(0, self.aspectRatio)
        )
        
        self.setPhysicalBody()
    }
    
    
    func toggleState() {
        self.setState(newState: self.otherState(self.state))
    }
    func otherState(_ state: State) -> State {
        switch state {
        case .left:     return .right
        case .right:    return .left
        case .up:       return .down
        case .down:     return .up
        default:
            print("case not covered")
            return state
        }
    }
    func getActionParameters(state: State) -> actionParameters {
        return [(0, 0)]
    }
    
    func setPhysicalBody() {
        let physicalSize = self.spriteLoader.getMaxSize()
        
        let physicalWidth = physicalSize.width/physicalSize.height*(touchbarHeight * abs(self.aspectRatio))
        let physicalHeight = touchbarHeight * abs(self.aspectRatio)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: physicalWidth, height: physicalHeight))
        
        physicsBody?.categoryBitMask = self.state.bitMask
        physicsBody?.contactTestBitMask = self.otherState(self.state).bitMask
        speed = 1
    }
    
    func setState(newState: State) {
        self.state = newState
    }
    
    func getDirVector(scale: CGFloat) -> (CGFloat, CGFloat) {
        let dir: (CGFloat, CGFloat)
        let sign = self.aspectRatio/abs(self.aspectRatio)
        switch self.state {
        case .up:       dir = ( 0, scale)
        case .down:     dir = ( 0,-scale)
        case .left:     dir = (-scale, 0)
        case .right:    dir = ( scale, 0)
        case .slide:    dir = ( sign*scale, 0)
        case .jump:     dir = ( sign*scale/sqrt(2), scale/sqrt(2))
        case .fall:     dir = ( 0, 0)
        case .sleep:    dir = ( 0, 0)
        case .idle:     dir = ( 0, 0)
        case .awake:    dir = ( 0, 0)
        default:        dir = ( 0, 0)
        }
        return dir
    }
    
    func performActions(params : actionParameters) {
        removeAllActions()
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        
        var actions: [SKAction] = [SKAction]()
        for i in 0..<params.count {
            if params[i].1 == 0 {
                break
            }
            actions.append(
                self.createAction(params[i].0, params[i].1, i == params.count-1)
            )
        }
        run( SKAction.sequence(actions) )
    }
    
    func createAction(_ actionNum: Int, _ time: TimeInterval, _ repeatForever: Bool) -> SKAction {
        let withTextures = self.spriteLoader.getAnimation(actionNum)
        let animate = SKAction.animate(with: withTextures, timePerFrame: time)
        
        let (xDir, yDir) = self.getDirVector(scale: self.speedDir)
        let numTimes = CGFloat(withTextures.count)
        let move = SKAction.moveBy(x: xDir/numTimes, y: yDir/numTimes, duration: time*numTimes)
        
        
        let animatedAction = repeatForever ? SKAction.repeatForever(animate) : SKAction.`repeat`(animate, count: 1)
        let moveAction = repeatForever ? SKAction.repeatForever(move) : SKAction.`repeat`(move, count: 1)
        let mirrorDirection = SKAction.scaleX(to: self.aspectRatio, duration:0.0)
        
        let resizeFactor = self.spriteLoader.getCurrentSize(actionNum).height / self.spriteLoader.getCurrentSize(17).height
//        TODO: (most average height?)
        let newSize = self.spriteLoader.getCurrentSize(actionNum, self.aspectRatio)
        let resizeAction = SKAction.resize(toHeight: newSize.height * resizeFactor, duration: 0.0)
        
        
        return SKAction.group([animatedAction, moveAction, mirrorDirection, resizeAction])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
