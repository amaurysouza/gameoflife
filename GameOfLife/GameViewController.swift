//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Amaury A V A Souza on 31/10/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController, SCNPhysicsContactDelegate {

    var sceneView: SCNView!
    var scene: SCNScene!
    var matriz = [[SCNNode]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        sceneView.showsStatistics = true
        matriz = setupMatriz()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(iteracaoGame), userInfo: nil, repeats: true)


    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        sceneView = self.view as? SCNView
        
        sceneView.allowsCameraControl = true
        
    }
    
    func setupScene(){
        scene = SCNScene(named: "Scene.scn")
        sceneView.scene = scene
        sceneView.scene?.physicsWorld.contactDelegate = self
        sceneView.scene?.background.contents = UIColor.white
    }
    
    func setupMatriz() -> [[SCNNode]]{

        let initializerNode = createDeadCubeNode(posX: 0, posY: 0)
        var matriz = [[SCNNode]](repeating: [SCNNode](repeating: initializerNode, count: 25), count: 25)
        
        for i in 0..<25{
            for j in 0..<25{
                let number = Int.random(in: 0..<5)
                if number == 1{
                    matriz[i][j].removeFromParentNode()
                    let aliveCubeNode = createAliveCubeNode(posX: Float(i), posY: Float(j))
                    matriz[i][j] = aliveCubeNode
                    scene.rootNode.addChildNode(matriz[i][j])
        
                }else{
                    matriz[i][j].removeFromParentNode()
                    let deadCubeNode = createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matriz[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matriz[i][j])
                }
            }
        }
        return matriz
    }
    
    func createDeadCubeNode(posX: Float, posY: Float) -> SCNNode {
        let deadCube:SCNGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        deadCube.materials.first?.diffuse.contents = UIColor.black
        let deadCubeNode = SCNNode(geometry: deadCube)
        deadCubeNode.position.x = Float(posX)
        deadCubeNode.position.z = Float(posY)
        deadCubeNode.position.y = 0.5
        deadCubeNode.name = "morto"
        return deadCubeNode
    }
    
    func createAliveCubeNode(posX: Float, posY: Float)-> SCNNode{
        let aliveCube:SCNGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        aliveCube.materials.first?.diffuse.contents = UIColor.red
        let aliveCubeNode = SCNNode(geometry: aliveCube)
        aliveCubeNode.position.x = posX
        aliveCubeNode.position.z = posY
        aliveCubeNode.position.y = 0.5
        aliveCubeNode.name = "vivo"
        return aliveCubeNode
    }
    
    func validaVariavel(i: Int, j: Int) -> Bool{
        if i<0{
            return false
        }
        if i>matriz.count-1{
            return false
        }
        if j<0{
            return false
        }
        if j>matriz.count-1{
            return false
        }
        return true
    }
    
    
    @objc func iteracaoGame(){
        
        var matrizAux = matriz
        
        for i in 0..<matriz.count{
            for j in 0..<matriz.count{
                var contadorDeVivos = 0
                if validaVariavel(i: i-1, j: j){
                    if matriz[i-1][j].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i-1, j: j-1){
                    if matriz[i-1][j-1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i-1, j: j+1){
                    if matriz[i-1][j+1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j){
                    if matriz[i+1][j].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j+1){
                    if matriz[i+1][j+1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j-1){
                    if matriz[i+1][j-1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i, j: j+1){
                    if matriz[i][j+1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i, j: j-1){
                    if matriz[i][j-1].name == "vivo"{
                        contadorDeVivos+=1
                    }
                }
                if contadorDeVivos < 2 && matriz[i][j].name == "vivo"{
                    matriz[i][j].removeFromParentNode()
                    let deadCubeNode = createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }else if contadorDeVivos>3 && matriz[i][j].name == "vivo"{
                    matriz[i][j].removeFromParentNode()
                    let deadCubeNode = createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }else if contadorDeVivos == 3 && matriz[i][j].name == "morto"{
                    matriz[i][j].removeFromParentNode()
                    let aliveCubeNode = createAliveCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = aliveCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }
            }
            
        }
        self.matriz = matrizAux
        
    }

}
