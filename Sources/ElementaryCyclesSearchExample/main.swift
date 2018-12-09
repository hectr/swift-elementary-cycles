/*
 (BSD-2 license)
 
 Original work Copyright (c) 2012, Frank Meyer
 All rights reserved.
 
 Swift port Copyright (c) 2018, Hèctor Marquès
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Swift
import ElementaryCyclesSearch

/**
 * Testfile for elementary cycle search.
 *
 * @author Frank Meyer
 *
 */

typealias Node = String

private func printCycles(_ cycles: Array<Array<Node>>) {
    for i in 0 ..< cycles.count {
        let cycle = cycles[i]
        for j in 0 ..< cycle.count {
            let node = cycle[j]
            if j < (cycle.count - 1) {
                print(node + " -> ", terminator: "")
            } else {
                print(node, terminator: "")
            }
        }
        print()
    }
}

let nodes: Array<Node> = {
    var vector = Array<Node>()
    for i in 0 ..< 10 {
        vector.append("Node \(i)")
    }
    return vector
}()

let adjMatrix: AdjacencyMatrix = {
    let adjMatrix = AdjacencyMatrix(10, 10) { matrix in
        /*matrix[0][1] = true
         matrix[1][2] = true
         matrix[2][0] = true
         matrix[2][4] = true
         matrix[1][3] = true
         matrix[3][6] = true
         matrix[6][5] = true
         matrix[5][3] = true
         matrix[6][7] = true
         matrix[7][8] = true
         matrix[7][9] = true
         matrix[9][6] = true;*/
        
        matrix[0][1] = true
        matrix[1][2] = true
        matrix[2][0] = true
        matrix[2][6] = true
        matrix[3][4] = true
        matrix[4][5] = true
        matrix[4][6] = true
        matrix[5][3] = true
        matrix[6][7] = true
        matrix[7][8] = true
        matrix[8][6] = true
        matrix[6][1] = true
    }
    return adjMatrix
}()

let cycles = ElementaryCyclesSearch.getElementaryCycles(adjacencyMatrix: adjMatrix, graphNodes: nodes)
printCycles(cycles)
