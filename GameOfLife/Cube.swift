//
//  Cube.swift
//  GameOfLife
//
//  Created by Amaury A V A Souza on 07/11/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import SceneKit

class Cube{
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
}
