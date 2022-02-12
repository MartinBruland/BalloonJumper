//
//  GameViewController.swift
//  Balloon Jumper
//
//  Created by Martin Bruland on 25/11/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: view.bounds.size)
            scene.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }
    

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
