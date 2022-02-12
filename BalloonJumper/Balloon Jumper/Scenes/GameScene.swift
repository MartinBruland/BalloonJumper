//
//  GameScene.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//


//MARK: IMPORT PACKAGES
import SpriteKit
import GameplayKit
import CoreMotion


// MARK: GAME SCENE
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // USER INTERFACE
    var HudLayer = Hud()
    var MenuLayer = MenuUI()
    
    // SOUNDS AND BACKGROUND MUSIC
    var sounds = SoundEffects()
    
    // MOVEMENT CONFIG.
    let motionManager = CMMotionManager() // Motion manager for accelerometer
    var xAcceleration: CGFloat = 0.0 // Acceleration value from accelerometer
    var accelerationSensitivity: CGFloat = 800.0 // Sensibility of accelerometer
    
    // GAME ENGINE CONFIG.
    let fallDistance = 1500;
    var platformBounce: CGFloat = 65.0;
    var groundBounce: CGFloat = 15.0;
    var worldGravity = -6.0;
    
    // COORDINATE SYSTEM CONFIG.
    var lastRow: CGFloat = 225.0
    var lastPlatformCoordinate = CGPoint(x: 0, y: 0)
    var rowCounter = 0
    
    // SPAWN CONFIG.
    var spawnCounter = 0
    var platformType1_spawnRate = 0
    var platformType2_spawnRate = 0
    var platformType3_spawnRate = 0
    var obstacle_spawnRate = 0
    var platformMovement = false
    var obstacleMovement = false
    
    // CONTAINER NODES.
    var backgroundNode = SKNode()
    var midgroundNode = SKNode()
    var foregroundNode = SKNode()
    var playerNode: SKSpriteNode!

    
    

    
    // MARK: GAME ENGINE
    override func didMove(to view: SKView) {

        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { _ in
            if !self.children.contains(self.MenuLayer.MenuUI) {
                self.showMenuUI(state: "PauseMenu")
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
                self.isPaused = true
        }
                
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: worldGravity)
        
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: .main) {
            
            (data, error) in guard let data = data, error == nil else { return }
            self.xAcceleration = (CGFloat(data.acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
            
        }
        
        states = States()
        
        // Dynamic Bounce
        if UIDevice.current.userInterfaceIdiom == .pad {
            platformBounce = platformBounce * 1.5
            groundBounce = groundBounce * 1.5
        }
        
    
        let HudUI = HudLayer.build()
        self.addChild(HudUI)

        showMenuUI(state: "StartMenu")

        buildWorld()
        spawnWorldObjects()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if playerNode.position.y > 300.0  {
            
            //backgroundNode.position = CGPoint(x: 0.0, y: -((playerNode.position.y - position_adjuster)/10))
            midgroundNode.position = CGPoint(x: 0.0, y: -(playerNode.position.y - 300.0))
            foregroundNode.position = CGPoint(x: 0.0, y: -(playerNode.position.y - 300.0))
            
        }
        
        states.currentPositionY = Int(playerNode.position.y)
        
        if states.currentPositionY > states.highestPositionY {
            
            states.highestPositionY = states.currentPositionY
            
        }
        
        let spawn_position = Int(lastRow - 500)
        
        if states.highestPositionY > spawn_position {
            
            spawnWorldObjects()
            
        }
        
        if states.currentPositionY < states.highestPositionY - fallDistance {
            
            showMenuUI(state: "GameOverMenu")
        }
        
        HudLayer.updateLabel2()
        
    }
    
    override func didSimulatePhysics() {
      
        playerNode.physicsBody?.velocity = CGVector(dx: xAcceleration * accelerationSensitivity, dy: playerNode.physicsBody!.velocity.dy)
        
        if playerNode.position.x < -20.0 {
           
            playerNode.position = CGPoint(x: self.size.width + 20.0, y: playerNode.position.y)
        
        } else if (playerNode.position.x > self.size.width + 20.0) {
        
            playerNode.position = CGPoint(x: -20.0, y: playerNode.position.y)
        
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var one: SKPhysicsBody
        var two: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            one = contact.bodyA
            two = contact.bodyB
            
        } else {
            
            one = contact.bodyB
            two = contact.bodyA
            
        }
        
        if one.categoryBitMask == ContactCategories.PlayerCategory {
            
            switch two.categoryBitMask {
            
                case ContactCategories.GroundCategory:
                    
                    playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: groundBounce))
                    break
                    
                case ContactCategories.CatapultCategory:
                    
                    playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: platformBounce))
                    
                    sounds.playSound(scene: self, action: sounds.platformSound1)
                    
                    break
                    
                case ContactCategories.PlatformCategory:
                    
                    let player_pos = playerNode.position.y - (playerNode.frame.size.height / 2)
                    let platform_pos = two.node!.position.y
                    
                    if player_pos > platform_pos {
       
                        playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: platformBounce))
                        
                        if two.node?.name == "Balloon_Fragile" {
                            
                            two.node?.removeFromParent()
                            
                            sounds.playSound(scene: self, action: sounds.platformSound3)
                            
                        } else {
                            
                            sounds.playSound(scene: self, action: sounds.platformSound1)
                            
                        }
                    }

                    break
                    
                case ContactCategories.CollectibleCategory:
                    
                    switch two.node?.name {
                        
                        case "COLLECTIBLE_COIN":
                            
                            sounds.playSound(scene: self, action: sounds.collectibleSound1)
                            states.updateScore()
                            HudLayer.updateLabel1()
                            
                            break
                       
                        default:
                            print("Something went wrong on collectible contact")
                            break
                        }
     
                    
                    two.node?.removeFromParent()
                    break
 
                    
                case ContactCategories.ObstacleCategory:
                
                    playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: -50.0))
                    playerNode.physicsBody?.collisionBitMask = 0
                    playerNode.physicsBody?.contactTestBitMask = 0
                    break
                    
                default:
                    
                    print("Something went wrong on obstacle contact..")
                    break
                    
            }
        }
        
        if one.categoryBitMask == ContactCategories.NodeRemoverCategory {
            
            switch two.categoryBitMask {
            
                case ContactCategories.PlatformCategory, ContactCategories.CollectibleCategory, ContactCategories.ObstacleCategory, ContactCategories.GroundCategory, ContactCategories.CatapultCategory:
                    
                    two.node?.removeFromParent()
                    break
                        
                default:
                    
                    print("Something went wrong on node remove contact")
                    break
            }
        }
    }
    

    

// MARK: VIEWS AND NAVIGATION.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            let nodesArray = self.nodes(at: location)
                        
            if nodesArray.first?.name == "Button_NewGame" {
                
                if states.convertPositionToAltitude(position: states.highestPositionY) > 0 { // greater than 0 must mean that game has been started.
                    
                    if let view = self.view {
                        
                        let scene = GameScene(size: view.bounds.size)
                        scene.anchorPoint = CGPoint(x: 0.0, y: 0.0)
                        view.presentScene(scene)
                        
                    }
                    
                }
                
                hideMenuUI()
                    
            }
            
            if nodesArray.first?.name == "Button_Continue" {
                
                hideMenuUI()
                
            }
            
            if nodesArray.first?.name == "Button_Pause" {
                
                showMenuUI(state: "PauseMenu")
                
            }
            
        }
    }
    
    func showMenuUI(state: String) {
        
        self.isPaused = true
        HudLayer.HudUI.isHidden = true
        
        MenuLayer.updateMenuData(state: state)
        
        if state == "GameOverMenu" {
            
            
            states.saveGame()
            
        }
        
        let item = MenuLayer.build()
        
        self.addChild(item)
        
    }
    
    func hideMenuUI() {
                
        self.isPaused = false
        HudLayer.HudUI.isHidden = false
        childNode(withName: "menuUI")?.removeAllChildren()
        childNode(withName: "menuUI")?.removeFromParent()
        
    }
    
    

    
//MARK: BUILD WORLD.
    
    func buildWorld() {
        
        backgroundNode.zPosition = 0
        midgroundNode.zPosition = 1
        foregroundNode.zPosition = 2
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.scale(to: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        background.position = CGPoint(x: 0.0, y: 0.0)
        
        let ground = Ground(position: CGPoint(x: UIScreen.main.bounds.midX, y: 20), size: CGSize(width: (UIScreen.main.bounds.width + 10), height: 40)).build()
        
        let catapult = Catapult(position: CGPoint(x: UIScreen.main.bounds.midX, y: 40.0), size: states.catapultSize).build()
        
        playerNode = Player(position: CGPoint(x: self.size.width / 1.1, y: 100), size: states.playerSize).build()

        let nodeRemover = NodeRemover(position: CGPoint(x: self.frame.midX, y: -150), size: CGSize(width: self.frame.maxX, height: 10)).build()
        
        if states.convertPositionToAltitude(position: states.highscorePositionY) > 1 {
            
            let highscoreMarker = HighscorePin(position: CGPoint(x: UIScreen.main.bounds.minX, y: CGFloat(states.highscorePositionY))).build()
            
            midgroundNode.addChild(highscoreMarker)
        }
        

        backgroundNode.addChild(background)
        foregroundNode.addChild(ground)
        foregroundNode.addChild(catapult)
        foregroundNode.addChild(playerNode)
        foregroundNode.addChild(nodeRemover)
        
        self.addChild(backgroundNode)
        self.addChild(midgroundNode)
        self.addChild(foregroundNode)
        
    }
    
    func spawnWorldObjects() {
        
        spawnCounter += 1
        
        if spawnCounter == 1 {
            
            print("LEVEL 1")
            platformType1_spawnRate = 3
            platformType2_spawnRate = 2
            platformType3_spawnRate = 0
            platformMovement = false
            obstacleMovement = false
            obstacle_spawnRate = 17
        
        } else if spawnCounter == 3 {
            
            print("LEVEL 2")
            platformType1_spawnRate = 1
            platformType2_spawnRate = 2
            platformType3_spawnRate = 3
            platformMovement = false
            obstacleMovement = false
            obstacle_spawnRate = 11
        
        } else if spawnCounter > 7 {
            
            print("LEVEL 3")
            platformType1_spawnRate = 1
            platformType2_spawnRate = 2
            platformType3_spawnRate = 4
            platformMovement = true
            obstacleMovement = false
            obstacle_spawnRate = 11
            
        } else if spawnCounter > 10 {
            
            print("LEVEL 4")
            platformType1_spawnRate = 1
            platformType2_spawnRate = 2
            platformType3_spawnRate = 4
            platformMovement = true
            obstacleMovement = true
            obstacle_spawnRate = 11
            
        }
        
        let coordinateSystem = CoordinateSystem(rowAmount: 20, columnAmount: 4, lastRow: lastRow).createCoordinates()
        
        let coordinates = coordinateSystem.sorted( by: { $0.0 < $1.0 })
        
        lastRow = (coordinates.last?.key)!
        
        for row in coordinates {
            
            let allColumns = row.value
            
            var randomColumn = allColumns.randomElement()!
           
            var coordinate = CGPoint(x: randomColumn, y: row.key)
            
            while coordinate.x == lastPlatformCoordinate.x {
                
                randomColumn = allColumns.randomElement()!
                
                coordinate = CGPoint(x: randomColumn, y: row.key)
                
            }
            
            if rowCounter % 2 == 0 {
                
                lastPlatformCoordinate = coordinate
                
                var allPlatforms = [Any]()

                for _ in 1...platformType1_spawnRate {
                    
                    let platform1 = Platform(position: CGPoint(x: coordinate.x, y: coordinate.y), size: states.platform1Size)
                    
                    allPlatforms.append(platform1.buildPlatform1())
                    
                }
                
                for _ in 1...platformType2_spawnRate {
                    
                    let platform2 = Platform(position: CGPoint(x: coordinate.x, y: coordinate.y), size: states.platform2Size)
                    
                    if platformMovement {
                        platform2.addPlatformMovement()
                    }
                    
                    allPlatforms.append(platform2.buildPlatform2())
                    
                }
                
                if platformType3_spawnRate != 0 {
                    for _ in 1...platformType3_spawnRate {
                        
                        let platform3 = Platform(position: CGPoint(x: coordinate.x, y: coordinate.y), size: states.platform1Size)
                        
                        allPlatforms.append(platform3.buildPlatform3())
                    }
                }
                
                let randomNumber = Int(arc4random_uniform(UInt32(allPlatforms.count)))
                let randomPlatform = allPlatforms[randomNumber]
                                
                foregroundNode.addChild(randomPlatform as! SKNode)
                
            } else {
                
                if (rowCounter % obstacle_spawnRate) == 0 {
                                        
                    let obstacle = Obstacle(position: CGPoint(x: coordinate.x, y: coordinate.y), size: states.obstacleSize)
                    
                    if obstacleMovement {
                        obstacle.add_movement()
                    }
                    
                    foregroundNode.addChild(obstacle.build())
                    
                } else {
                    
                    let positions = Collectible(position: CGPoint(x: coordinate.x, y: coordinate.y), size: states.collectibleSize).getRandomShape()
                    
                    for pos in positions {
                        
                        let collectible = Collectible(position: CGPoint(x: pos.x, y: pos.y), size: states.collectibleSize).build()

                        foregroundNode.addChild(collectible)
                        
                    }
                }
            }
            
            rowCounter += 1
    
        }
    }
}
