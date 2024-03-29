//
//  GameScene.swift
//  Pin-UpCasino
//
//  Created by Oleg Yakushin on 3/28/24.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var hasContactedBottom = false
    var gameManager: GameManager
    var playerBottom: SKSpriteNode!
    var playerTop: SKSpriteNode!
    var ball: SKSpriteNode!
    var playerBottomTouch: UITouch?
    var startTime: Int = 0
    var score = 0
    var restartButton: SKSpriteNode?
    var isGameOver = false
    init(size: CGSize, gameManager: GameManager, isPaused: Bool) {
           self.gameManager = gameManager
           super.init(size: size)
       }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
         physicsWorld.contactDelegate = self
      
        startTime = Int(Date().timeIntervalSince1970)
         // Set up bottom player panel
        let playerBottomTexture = SKTexture(imageNamed: "playBottom")
        playerBottom = SKSpriteNode(texture: playerBottomTexture, size: CGSize(width: 108 * sizeScreen(), height: 31 * sizeScreen()))

         playerBottom.position = CGPoint(x: frame.midX, y: playerBottom.size.height / 2 + 20)
         playerBottom.physicsBody = SKPhysicsBody(rectangleOf: playerBottom.size)
         playerBottom.physicsBody?.isDynamic = false
         addChild(playerBottom)
         
   
        let playerTopTexture = SKTexture(imageNamed: "playTop")
         playerTop = SKSpriteNode(texture: playerTopTexture, size: CGSize(width: 108 * sizeScreen(), height: 31 * sizeScreen()))
         playerTop.position = CGPoint(x: frame.minX, y: frame.height - playerTop.size.height / 2)
         playerTop.physicsBody = SKPhysicsBody(rectangleOf: playerTop.size)
         playerTop.physicsBody?.isDynamic = false
         addChild(playerTop)
        restartButton = SKSpriteNode(imageNamed: "playBottom")
        restartButton?.position = CGPoint(x: frame.midX, y: frame.midY)
        restartButton?.isHidden = true
        addChild(restartButton!)
        
        let ballTexture = SKTexture(imageNamed: gameManager.game?.selectedBall ?? "newbie")
        ball = SKSpriteNode(texture: ballTexture, size: CGSize(width: 45 * sizeScreen(), height: 45 * sizeScreen()))
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 22.5 * sizeScreen())
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.linearDamping = 0.0
        ball.physicsBody?.angularDamping = 0.0
        ball.physicsBody?.contactTestBitMask = playerBottom.physicsBody!.collisionBitMask | playerTop.physicsBody!.collisionBitMask
        ball.physicsBody?.affectedByGravity = false
        addChild(ball)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        playerBottom.physicsBody?.categoryBitMask = PhysicsCategory.Player


       
        let initialSpeed: CGFloat = 200.0 * CGFloat(gameManager.game?.gameSpeed ?? 1)
        let dx = cos(CGFloat.pi / 4) * initialSpeed // cos(45 degrees) = sqrt(2) / 2
        let dy = -sin(CGFloat.pi / 4) * initialSpeed // -sin(45 degrees) = -sqrt(2) / 2
        ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
         // Set up walls
         let wall = SKPhysicsBody(edgeLoopFrom: frame)
         wall.friction = 0
         wall.restitution = 1
         self.physicsBody = wall
         
    
         let randomX = CGFloat.random(in: -1...1)
         let randomY = CGFloat.random(in: -1...1)
         ball.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
         let screenWidth = frame.width
         // Make top player panel move back and forth
        let moveLeftAction = SKAction.moveBy(x: screenWidth, y: 0, duration: 1)
        let moveRightAction = SKAction.moveBy(x: -screenWidth, y: 0, duration: 1)
         let moveAction = SKAction.sequence([moveLeftAction, moveRightAction])
         playerTop.run(SKAction.repeatForever(moveAction))
         }
         
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)
            if playerBottom.frame.contains(touchLocation) {
                playerBottomTouch = touch
            }
    }

         
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let playerBottomTouch = playerBottomTouch else { return }
        let touchLocation = touch.location(in: self)
        if touch == playerBottomTouch {
            playerBottom.position.x = touchLocation.x
        }
    }
         
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let ball = ball else { return }
        
     
        let touchLocation = touch.location(in: self)
        
       
        let ballCenter = ball.position
        
       
        let distance = sqrt(pow(touchLocation.x - ballCenter.x, 2) + pow(touchLocation.y - ballCenter.y, 2))
        
        
        if distance <= 30 {
            score += 1
            print(score)
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
            let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
            
           
            if contactMask == PhysicsCategory.Ball | PhysicsCategory.Player && !hasContactedBottom {
               
                score += 1
                print("Score: \(score)")
                gameManager.updateCurrenrScore(score: score)
                
            
               
            }
        }
    func endGame() {
        guard !isGameOver else { return } // Проверяем, не была ли уже окончена игра
        let currentTimeInSeconds = Int(Date().timeIntervalSince1970)
        let gameTimeInSeconds = currentTimeInSeconds - startTime
        if gameTimeInSeconds > gameManager.game!.longestTime {
            gameManager.updateLongestTime(time: gameTimeInSeconds)
        }
        if score > gameManager.game!.maxScore {
            gameManager.updateScore(score: score)
        }
        gameManager.addScore(score: score)
        gameManager.endGame(isEnd: true)
       startTime = 0
        physicsWorld.speed = 0
        gameManager.updateGamesPlayed()
        restartButton?.isHidden = false
        isGameOver = true
        playerTop.removeAllActions()
      }
   
    func restartGame() {
           score = 0
           self.isPaused = false
           restartButton?.isHidden = true
        isGameOver = false
       }
    
    override func update(_ currentTime: TimeInterval) {
        if isPaused {
            physicsWorld.speed = 0
            
            playerTop.removeAllActions()
               }
    
            if ball.position.y  <=  playerBottom.size.height / 2 + 10 {
                   endGame()
               }
           
        let currentTimeInSeconds = Int(Date().timeIntervalSince1970)
        let gameTimeInSeconds = currentTimeInSeconds - startTime
       }
}

struct PhysicsCategory {
    static let Ball: UInt32 = 0x1 << 0
    static let Player: UInt32 = 0x1 << 1
}
