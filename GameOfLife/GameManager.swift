//
//  GameManager.swift
//  GameOfLife
//
//  Created by Amaury A V A Souza on 07/11/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import SceneKit

class GameManager{
    
    
    var scene: SCNScene!
    var cubeCreator = Cube()
    var matriz = [[SCNNode]]()
    
    init(){
        scene = SCNScene(named: "Scene.scn")
        scene.background.contents = UIColor.white
        let tamanhoHor = 25
               let tamanhoVert = 50
               let initializerNode = cubeCreator.createDeadCubeNode(posX: 0, posY: 0)
            matriz = [[SCNNode]](repeating: [SCNNode](repeating: initializerNode, count: tamanhoVert), count: tamanhoHor)
               
               for i in 0..<tamanhoHor{
                   for j in 0..<tamanhoVert{
                       let number = Int.random(in: 0..<5)
                       if number == 1{
                           matriz[i][j].removeFromParentNode()
                           let aliveCubeNode = cubeCreator.createAliveCubeNode(posX: Float(i), posY: Float(j))
                           matriz[i][j] = aliveCubeNode
                           scene.rootNode.addChildNode(matriz[i][j])
               
                       }else{
                           matriz[i][j].removeFromParentNode()
                           let deadCubeNode = cubeCreator.createDeadCubeNode(posX: Float(i), posY: Float(j))
                           matriz[i][j] = deadCubeNode
                           scene.rootNode.addChildNode(matriz[i][j])
                       }
                   }
               }

    }
    
    func setupMatriz(){
        let tamanhoHor = 25
        let tamanhoVert = 50
        let initializerNode = cubeCreator.createDeadCubeNode(posX: 0, posY: 0)
        var matriz = [[SCNNode]](repeating: [SCNNode](repeating: initializerNode, count: tamanhoVert), count: tamanhoHor)
        
        for i in 0..<tamanhoHor{
            for j in 0..<tamanhoVert{
                let number = Int.random(in: 0..<5)
                if number == 1{
                    matriz[i][j].removeFromParentNode()
                    let aliveCubeNode = cubeCreator.createAliveCubeNode(posX: Float(i), posY: Float(j))
                    matriz[i][j] = aliveCubeNode
                    scene.rootNode.addChildNode(matriz[i][j])
        
                }else{
                    matriz[i][j].removeFromParentNode()
                    let deadCubeNode = cubeCreator.createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matriz[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matriz[i][j])
                }
            }
        }
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
        if j>matriz[0].count-1{
            return false
        }
        return true
    }

    func iteracaoGame(){
        
        var matrizAux = matriz
        
        for i in 0..<matriz.count{
            for j in 0..<matriz[0].count{
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
                    let deadCubeNode = cubeCreator.createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }else if contadorDeVivos>3 && matriz[i][j].name == "vivo"{
                    matriz[i][j].removeFromParentNode()
                    let deadCubeNode = cubeCreator.createDeadCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = deadCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }else if contadorDeVivos == 3 && matriz[i][j].name == "morto"{
                    matriz[i][j].removeFromParentNode()
                    let aliveCubeNode = cubeCreator.createAliveCubeNode(posX: Float(i), posY: Float(j))
                    matrizAux[i][j] = aliveCubeNode
                    scene.rootNode.addChildNode(matrizAux[i][j])
                }
            }
            
        }
        matriz =  matrizAux
        
    }

    


}
