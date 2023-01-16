//
//  Scene.swift
//  touchbar
//
//  Created by David Garcia on 3/30/22.
//

import SpriteKit

let longTapTime: TimeInterval = 0.5
let spriteSpawnY: CGFloat = touchbarHeight/2.0
var sprites: [Sprite] = [Sprite]()

protocol SceneChild {
    func getSprite() -> Sprite
    func customDidBegin(_ spriteA: Sprite, _ spriteB: Sprite) -> ()
    func customTouchesBegan(_ location: CGPoint) -> ()
    func customTouchesMoved(_ location: CGPoint) -> ()
    func customTouchesEnded(_ location: CGPoint) -> ()
    func customUpdate(_ currentTime: TimeInterval) -> ()
}


class Scene: SKScene, SKPhysicsContactDelegate {
    
    func getSprite() -> Sprite { return TemplateSprite() }
    func customDidBegin(_ spriteA: Sprite, _ spriteB: Sprite) -> () {}
    func customTouchesBegan(_ location: CGPoint) -> () {}
    func customTouchesMoved(_ location: CGPoint) -> () {}
    func customTouchesEnded(_ location: CGPoint) -> () {}
    func customUpdate(_ currentTime: TimeInterval) -> () {}
    
    let backgroundFile: String
    var touchStarted: TimeInterval?
    let gravityVector: CGVector
    
    init(backgroundFile: String, gravityVector: CGVector = CGVector.init(dx: 0, dy: -1)) {
        self.backgroundFile = backgroundFile
        self.gravityVector = gravityVector
        super.init(size: CGSize(width: touchbarWidth, height: touchbarHeight))
    }
    
    
    func initScene() {
        self.scene?.removeAllChildren()
        
        self.touchStarted = nil
        
        self.isUserInteractionEnabled = true
        self.scaleMode = .resizeFill
        self.physicsWorld.gravity = self.gravityVector
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.clear;
        let background = SKSpriteNode(
            texture: SKTexture(imageNamed: self.backgroundFile),
            color: NSColor.clear,
            size: frame.size
        )
        
        addChild(background)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        
        sprites = [Sprite]()
    }
    
    override func didMove(to view: SKView) {
        self.initScene()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let spriteA = contact.bodyA.node as? Sprite,
           let spriteB = contact.bodyB.node as? Sprite {
            var left = spriteA
            var right = spriteB
            if spriteB.position.x < spriteA.position.x {
                left = spriteB
                right = spriteA
            }

            self.customDidBegin(left, right)
        }
    }
    
    func addSprite(at: CGPoint) {
        let s: Sprite = self.getSprite()
        self.scene?.addChild(s)
        
        s.position = at
        s.constraints = [SKConstraint.positionY(SKRange(lowerLimit: spriteSpawnY))]
        s.state = { s.state }()
        sprites.append(s)
    }
    
    func spriteAt(point: CGPoint) -> Sprite? {
        return sprites.filter { $0.contains(point) }.first
    }
    
    override func touchesBegan(with event: NSEvent) {
        if #available(OSX 10.12.2, *) { if let touch = event.allTouches().first {
            self.touchStarted = event.timestamp
            self.customTouchesBegan(
                CGPoint(x: touch.location(in: self.view).x, y: touch.location(in: self.view).y)
            )
        }}
    }
    
    override func touchesMoved(with event: NSEvent) {
        if #available(OSX 10.12.2, *) { if let touch = event.allTouches().first {
            if self.touchStarted != nil {
                self.touchStarted = nil
                self.customTouchesMoved(
                    CGPoint(x: touch.location(in: self.view).x, y: touch.location(in: self.view).y)
                )
            }
        }}
    }
    
    
    override func touchesEnded(with event: NSEvent) {
        if #available(OSX 10.12.2, *) { if let touch = event.allTouches().first {
            if let startTime = self.touchStarted, event.timestamp - startTime < longTapTime{
                self.touchStarted = nil
                self.customTouchesEnded(
                    CGPoint(x: touch.location(in: self.view).x, y: spriteSpawnY)
                )
            }
        }}
    }
    
    override func update(_ currentTime: TimeInterval) {
        // clear scene
        let deadline = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            if let startTime = self.touchStarted, currentTime - startTime >= longTapTime {
                self.initScene()
            }
            else {
                self.customUpdate(currentTime)
            }
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

