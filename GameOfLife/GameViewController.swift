//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Amaury A V A Souza on 31/10/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import SceneKit

enum BodyType:UInt32{
    case alive = 1
}


class GameViewController: UIViewController, SCNPhysicsContactDelegate {

    var sceneView: SCNView!
    var scene: SCNScene!
    var matriz = [[Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupSceneCubes()
        sceneView.showsStatistics = true
        matriz = setupMatrix()
        printMatrix(matriz: matriz)
        matriz = iteracaoGame(matriz: matriz)
        printMatrix(matriz: matriz)
        matriz = iteracaoGame(matriz: matriz)
        printMatrix(matriz: matriz)
        matriz = iteracaoGame(matriz: matriz)
        printMatrix(matriz: matriz)
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
        
        
        
    }

    func setupSceneCubes(){
        let whiteCube:SCNGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        whiteCube.materials.first?.diffuse.contents = UIColor.white
        
        let blackCube:SCNGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        blackCube.materials.first?.diffuse.contents = UIColor.black
       
        
        
        let xPos: float_t = -50
        let zPos: float_t = 50
        
//        let action = SCNAction.rotateBy(x: 10, y: 10, z: 0, duration: 1)
//        let repeatAction = SCNAction.repeatForever(action)
        for i in stride(from: 50, through: xPos, by: -1){
            for j in stride(from: -50, through: zPos, by: +1){
                let number = Int.random(in: 0..<10)
                
                 if number == 1{
                    let blackCubeNode = SCNNode(geometry: blackCube)
                                        blackCubeNode.position.x = i
                                        blackCubeNode.position.z = j
                                        blackCubeNode.position.y = 0.5
                                        scene.rootNode.addChildNode(blackCubeNode)
//                    blackCubeNode.physicsBody = SCNPhysicsBody(type: .static, shape: .init(geometry: blackCube, options: .none))
//                    blackCubeNode.physicsBody?.categoryBitMask = Int(BodyType.alive.rawValue)
//                    blackCubeNode.physicsBody?.collisionBitMask = Int(BodyType.alive.rawValue)
//                    blackCubeNode.physicsBody?.contactTestBitMask = Int(BodyType.alive.rawValue)
//                    blackCubeNode.runAction(repeatAction)
                    
                    
                 }else{
                    let whiteCubeNode = SCNNode(geometry: whiteCube)
                    whiteCubeNode.position.x = i
                    whiteCubeNode.position.z = j
                    whiteCubeNode.position.y = 0.5
                    scene.rootNode.addChildNode(whiteCubeNode)

                     
                 } 

            }
        }
  
                
        
        
    }
    func setupMatrix() -> [[Int]]{
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
        for i in 0..<matrix.count{
            for j in 0..<matrix.count{
                let number = Int.random(in: 0..<5)
                if number == 1{
                    matrix[i][j] = 1
        
                }else{
                    matrix[i][j] = 0
                }
            }
        }
        return matrix
    }
    
    func printMatrix(matriz: [[Int]]){
        for i in 0..<matriz.count{
            print(matriz[i])
        }
        print("-----------------------------")
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
    
    
    func iteracaoGame(matriz: [[Int]]) -> [[Int]]{
        
        var matrizAux = matriz
        
        for i in 0..<matriz.count{
            for j in 0..<matriz.count{
                var contadorDeVivos = 0
                if validaVariavel(i: i-1, j: j){
                    if matriz[i-1][j] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i-1, j: j-1){
                    if matriz[i-1][j-1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i-1, j: j+1){
                    if matriz[i-1][j+1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j){
                    if matriz[i+1][j] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j+1){
                    if matriz[i+1][j+1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i+1, j: j-1){
                    if matriz[i+1][j-1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i, j: j+1){
                    if matriz[i][j+1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if validaVariavel(i: i, j: j-1){
                    if matriz[i][j-1] == 1{
                        contadorDeVivos+=1
                    }
                }
                if contadorDeVivos < 2 && matriz[i][j] == 1{
                    matrizAux[i][j] = 0
                }else if contadorDeVivos>3 && matriz[i][j] == 1{
                    matrizAux[i][j] = 0
                }else if contadorDeVivos == 3 && matriz[i][j] == 0{
                    matrizAux[i][j] = 1
                }
            }
            
        }
        return matrizAux
        
    }


}
