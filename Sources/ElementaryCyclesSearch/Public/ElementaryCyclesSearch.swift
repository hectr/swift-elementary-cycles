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
import Idioms

/**
 * Searchs all elementary cycles in a given directed graph. The implementation
 * is independent from the concrete objects that represent the graphnodes, it
 * just needs an array of the objects representing the nodes the graph
 * and an adjacency-matrix of type boolean, representing the edges of the
 * graph. It then calculates based on the adjacency-matrix the elementary
 * cycles and returns a list, which contains lists itself with the objects of the
 * concrete graphnodes-implementation. Each of these lists represents an
 * elementary cycle.<br><br>
 *
 * The implementation uses the algorithm of Donald B. Johnson for the search of
 * the elementary cycles. For a description of the algorithm see:<br>
 * Donald B. Johnson: Finding All the Elementary Circuits of a Directed Graph.
 * SIAM Journal on Computing. Volumne 4, Nr. 1 (1975), pp. 77-84.<br><br>
 *
 * The algorithm of Johnson is based on the search for strong connected
 * components in a graph. For a description of this part see:<br>
 * Robert Tarjan: Depth-first search and linear graph algorithms. In: SIAM
 * Journal on Computing. Volume 1, Nr. 2 (1972), pp. 146-160.<br>
 *
 * @author Frank Meyer, web_at_normalisiert_dot_de
 * @version 1.2, 22.03.2009
 *
 */
public class ElementaryCyclesSearch<Node> {
    /** List of cycles */
    private var cycles: [[Node]]
    
    /** Adjacency-list of graph */
    private var adjacencyList: AdjacencyList
    
    /** Graphnodes */
    private var graphNodes: [Node]
    
    /** Blocked nodes, used by the algorithm of Johnson */
    private var blocked: Vector<Bool>
    
    /** B-Lists, used by the algorithm of Johnson */
    private var B: Matrix2D<Int>
    
    /** Stack for nodes, used by the algorithm of Johnson */
    private var stack: [Int]
    
    /**
     * Returns List::List::Object with the Lists of nodes of all elementary
     * cycles in the graph.
     *
     * @param adjacencyMatrix adjacency-matrix of the graph
     * @param graphNodes array of the graphnodes of the graph; this is used to
     * build sets of the elementary cycles containing the objects of the original
     * graph-representation
     *
     * @return List::List::Object with the Lists of the elementary cycles.
     */
    public static func getElementaryCycles(adjacencyMatrix: AdjacencyMatrix, graphNodes: [Node]) -> [[Node]] {
        let ecs = ElementaryCyclesSearch(adjacencyMatrix: adjacencyMatrix, graphNodes: graphNodes)
        return ecs.getElementaryCycles()
    }

    /**
     * Constructor.
     *
     * @param adjacencyMatrix adjacency-matrix of the graph
     * @param graphNodes array of the graphnodes of the graph; this is used to
     * build sets of the elementary cycles containing the objects of the original
     * graph-representation
     */
    private init(adjacencyMatrix: AdjacencyMatrix, graphNodes: [Node]) {
        self.graphNodes = graphNodes;
        self.adjacencyList = AdjacencyList.getAdjacencyList(adjacencyMatrix: adjacencyMatrix)
        cycles = [[Node]]()
        blocked = Vector<Bool>(adjacencyList.reservedLength)
        B = Matrix2D<Int>(adjacencyList.reservedLength)
        stack = [Int]()
    }
    
    /**
     * Returns List::List::Object with the Lists of nodes of all elementary
     * cycles in the graph.
     *
     * @return List::List::Object with the Lists of the elementary cycles.
     */
    private func getElementaryCycles() -> [[Node]] {
        let sccs = StrongConnectedComponents(adjacencyList: adjacencyList)
        var s = 0
        
        while true {
            if let sccResult = sccs.getAdjacencyList(node: s) {
                let strongConnectedComponents = sccResult.getAdjList()
                s = sccResult.getLowestNodeId()
                for j in 0 ..< strongConnectedComponents.reservedLength {
                    if (strongConnectedComponents[j] != nil) && (strongConnectedComponents[j].size > 0) {
                        blocked[j] = false
                        B[j] = Vector<Int>()
                    }
                }
                
                _ = findCycles(v: s, s: s, adjacencyList: strongConnectedComponents)
                s += 1
            } else {
                break
            }
        }
        
        return cycles;
    }
    
    /**
     * Calculates the cycles containing a given node in a strongly connected
     * component. The method calls itself recursivly.
     *
     * @param v
     * @param s
     * @param adjacencyList adjacency-list with the subgraph of the strongly
     * connected component s is part of.
     * @return true, if cycle found; false otherwise
     */
    private func findCycles(v: Int, s: Int, adjacencyList: AdjacencyList) -> Bool {
        var f = false
        stack.append(v)
        blocked[v] = true
        
        for i in 0 ..< adjacencyList[v].size {
            let w = adjacencyList[v].get(i)
            // found cycle
            if w == s {
                var cycle = [Node]()
                for j in 0 ..< stack.count {
                    let index = stack[j]
                    let node = graphNodes[index] // WARNING guard
                    cycle.append(node)
                }
                cycles.append(cycle)
                f = true
            } else if !(blocked[w] ?? false) {
                if findCycles(v: w, s: s, adjacencyList: adjacencyList) {
                    f = true
                }
            }
        }
        
        if f {
            unblock(node: v)
        } else {
            for i in 0 ..< adjacencyList[v].size {
                let w = adjacencyList[v].get(i)
                if !B[w].contains(v) {
                    B[w].add(v)
                }
            }
        }

        if let index = stack.firstIndex(of: v) {
            stack.remove(at: index)
        }
        return f
    }
    
    /**
     * Unblocks recursivly all blocked nodes, starting with a given node.
     *
     * @param node node to unblock
     */
    private func unblock(node: Int) {
        blocked[node] = false
        guard let Bnode = B[node] else { return }
        while Bnode.size > 0 {
            let w = Bnode.get(0)
            Bnode.remove(at: 0)
            if let isBlocked = blocked[w], isBlocked {
                unblock(node: w)
            }
        }
    }
}
