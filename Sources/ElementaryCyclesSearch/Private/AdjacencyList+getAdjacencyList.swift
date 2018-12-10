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

/**
 * Calculates the adjacency-list for a given adjacency-matrix.
 *
 *
 * @author Frank Meyer, web@normalisiert.de
 * @version 1.0, 26.08.2006
 *
 */
extension Matrix where Element == Int {
    /**
     * Calculates a adjacency-list for a given array of an adjacency-matrix.
     *
     * @param adjacencyMatrix array with the adjacency-matrix that represents
     * the graph
     * @return int[][]-array of the adjacency-list of given nodes. The first
     * dimension in the array represents the same node as in the given
     * adjacency, the second dimension represents the indicies of those nodes,
     * that are direct successornodes of the node.
     */
    static func getAdjacencyList(adjacencyMatrix: AdjacencyMatrix) -> Matrix<Int> {
        let list = Matrix<Int>(adjacencyMatrix.reservedLength)
        
        for i in 0 ..< adjacencyMatrix.reservedLength {
            var v = [Int]()
            for j in 0 ..< adjacencyMatrix[i].reservedLength {
                if let isAdjacent = adjacencyMatrix[i]?[j], isAdjacent {
                    v.append(j)
                }
            }

            list[i] = Vector(v.count)
            for j in 0 ..< v.count {
                let integer = v[j]
                list[i][j] = integer
            }
        }
        
        return list;
    }
}
