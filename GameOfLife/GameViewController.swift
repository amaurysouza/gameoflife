//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Amaury A V A Souza on 31/10/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    var scene: SCNScene!
    var matriz = [[SCNNode]]()
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        sceneView.showsStatistics = true
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (Timer) in
            self.gameManager.iteracaoGame()
        }

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        sceneView = self.view as? SCNView
        sceneView.scene = gameManager.scene
        sceneView.allowsCameraControl = true

    }
}
