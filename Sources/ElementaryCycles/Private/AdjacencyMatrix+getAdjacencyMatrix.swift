/*
 (BSD-2 license)

 Copyright (c) 2018, Hèctor Marquès

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Swift
import ElementaryCyclesSearch

extension Matrix where Element == Bool {
    enum Error: Swift.Error {
        case indexNotFound(node: AnyHashable, nodes: [AnyHashable])
    }

    static func getAdjacencyMatrix<Node: Hashable>(nodes: [Node], adjacencyDictionary: [Node: [Node]]) throws -> AdjacencyMatrix {
        let matrix = AdjacencyMatrix(nodes.count, nodes.count)
        for (offset, node) in nodes.enumerated() {
            if let adjacentNodes = adjacencyDictionary[node] {
                for adjacentNode in adjacentNodes {
                    guard let adjacentIndex = nodes.firstIndex(of: adjacentNode) else {
                        throw Error.indexNotFound(node: adjacentNode, nodes: nodes)
                    }
                    matrix[offset][adjacentIndex] = true
                }
            }
        }
        return matrix
    }
}
