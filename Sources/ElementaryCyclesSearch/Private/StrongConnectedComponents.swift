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
 * This is a helpclass for the search of all elementary cycles in a graph
 * with the algorithm of Johnson. For this it searches for strong connected
 * components, using the algorithm of Tarjan. The constructor gets an
 * adjacency-list of a graph. Based on this graph, it gets a nodenumber s,
 * for which it calculates the subgraph, containing all nodes
 * {s, s + 1, ..., n}, where n is the highest nodenumber in the original
 * graph (e.g. it builds a subgraph with all nodes with higher or same
 * nodenumbers like the given node s). It returns the strong connected
 * component of this subgraph which contains the lowest nodenumber of all
 * nodes in the subgraph.<br><br>
 *
 * For a description of the algorithm for calculating the strong connected
 * components see:<br>
 * Robert Tarjan: Depth-first search and linear graph algorithms. In: SIAM
 * Journal on Computing. Volume 1, Nr. 2 (1972), pp. 146-160.<br>
 * For a description of the algorithm for searching all elementary cycles in
 * a directed graph see:<br>
 * Donald B. Johnson: Finding All the Elementary Circuits of a Directed Graph.
 * SIAM Journal on Computing. Volumne 4, Nr. 1 (1975), pp. 77-84.<br><br>
 *
 * @author Frank Meyer, web_at_normalisiert_dot_de
 * @version 1.1, 22.03.2009
 *
 */
class StrongConnectedComponents {
    class Result {
        private var nodeIDsOfSCC: Set<Int>
        private var adjacencyList: AdjacencyList
        private var lowestNodeId = -1
        
        fileprivate init(adjacencyList: AdjacencyList, lowestNodeId: Int) {
            self.lowestNodeId = lowestNodeId
            self.nodeIDsOfSCC = Set<Int>()
            self.adjacencyList = adjacencyList;
            for i in self.lowestNodeId ..< self.adjacencyList.reservedLength {
                if let adj = adjacencyList[i], adj.size > 0 {
                    self.nodeIDsOfSCC.insert(i)
                }
            }
        }
        
        func getAdjList() -> AdjacencyList {
            return adjacencyList
        }
        
        func getLowestNodeId() -> Int {
            return lowestNodeId
        }
    }

    /** Adjacency-list of original graph */
    private var adjacencyListOriginal: AdjacencyList!
    
    /** Adjacency-list of currently viewed subgraph */
    private var adjacencyList: AdjacencyList!
    
    /** Helpattribute for finding scc's */
    private var visited: Vector<Bool>!
    
    /** Helpattribute for finding scc's */
    private var stack: [Int]!
    
    /** Helpattribute for finding scc's */
    private var lowlink: Vector<Int>!
    
    /** Helpattribute for finding scc's */
    private var number: Vector<Int>!
    
    /** Helpattribute for finding scc's */
    private var strongConnectedComponentsCounter = 0;
    
    /** Helpattribute for finding scc's */
    private var currentStrongConnectedComponents: [[Int]]!
    
    /**
     * Constructor.
     *
     * @param adjacencyList adjacency-list of the graph
     */
    init(adjacencyList: AdjacencyList) {
        self.adjacencyListOriginal = adjacencyList;
    }
    
    /**
     * This method returns the adjacency-structure of the strong connected
     * component with the least vertex in a subgraph of the original graph
     * induced by the nodes {s, s + 1, ..., n}, where s is a given node. Note
     * that trivial strong connected components with just one node will not
     * be returned.
     *
     * @param node node s
     * @return SCCResult with adjacency-structure of the strong
     * connected component; null, if no such component exists
     */
    func getAdjacencyList(node: Int) -> Result? {
        visited = Vector<Bool>(self.adjacencyListOriginal.reservedLength)
        lowlink = Vector<Int>(self.adjacencyListOriginal.reservedLength)
        number = Vector<Int>(self.adjacencyListOriginal.reservedLength)
        visited = Vector<Bool>(self.adjacencyListOriginal.reservedLength)
        stack = [Int]()
        currentStrongConnectedComponents = [[Int]]()

        makeAdjacencyListSubgraph(node: node);
        
        for i in node ..< self.adjacencyListOriginal.reservedLength {
            let isVisited = visited[i] ?? false
            if !isVisited {
                getStrongConnectedComponents(root: i)
                let lowestIdComponent = getLowestIdComponent()
                if let nodes = lowestIdComponent, !nodes.contains(node), !nodes.contains(node + 1) {
                    return getAdjacencyList(node: node + 1);
                } else {
                    if let adjacencyList = getAdjList(nodes: lowestIdComponent) {
                        for j in 0 ..< self.adjacencyListOriginal.reservedLength {
                            if adjacencyList[j].size > 0 {
                                return Result(adjacencyList: adjacencyList, lowestNodeId: j);
                            }
                        }
                    }
                }
            }
        }
        
        return nil;
    }
    
    /**
     * Builds the adjacency-list for a subgraph containing just nodes
     * >= a given index.
     *
     * @param node Node with lowest index in the subgraph
     */
    private func makeAdjacencyListSubgraph(node: Int) {
        adjacencyList = AdjacencyList(adjacencyListOriginal.reservedLength, 0)
        
        for i in node ..< adjacencyList.reservedLength {
            var successors = [Int]()
            for j in 0 ..< self.adjacencyListOriginal[i].reservedLength {
                guard let original = adjacencyListOriginal[i]?[j] else { continue }
                if original >= node {
                    successors.append(original)
                }
            }
            if successors.count > 0 {
                adjacencyList[i] = Vector(successors.count)
                for j in 0 ..< successors.count {
                    let succ = successors[j]
                    adjacencyList[i][j] = succ
                }
            }
        }
    }

    /**
     * Calculates the strong connected component out of a set of scc's, that
     * contains the node with the lowest index.
     *
     * @return Vector::Integer of the strongConnectedComponents containing the lowest nodenumber
     */
    private func getLowestIdComponent() -> [Int]? {
        var min = adjacencyList.reservedLength;
        var currScc: [Int]?
        
        for i in 0 ..< currentStrongConnectedComponents.count {
            let strongConnectedComponents = currentStrongConnectedComponents[i]
            for j in 0 ..< strongConnectedComponents.count {
                let node = strongConnectedComponents[j]
                if node < min {
                    currScc = strongConnectedComponents
                    min = node
                }
            }
        }
        
        return currScc;
    }

    /**
     * @return Vector[]::Integer representing the adjacency-structure of the
     * strong connected component with least vertex in the currently viewed
     * subgraph
     */
    private func getAdjList(nodes: [Int]?) -> AdjacencyList? {
        guard let nodes = nodes else { return nil }
        let lowestIdAdjacencyList = AdjacencyList(adjacencyList.reservedLength)
        for i in 0 ..< lowestIdAdjacencyList.reservedLength {
            lowestIdAdjacencyList[i] = Vector<Int>()
        }
        for i in 0 ..< nodes.count {
            let node = nodes[i]
            guard let adjListNode = adjacencyList[node] else { continue }
            for j in 0 ..< adjListNode.reservedLength {
                guard let succ = adjacencyList[node]?[j] else { continue }
                if nodes.contains(succ) {
                    lowestIdAdjacencyList[node].add(succ)
                }
            }
        }
        
        return lowestIdAdjacencyList;
    }

    /**
     * Searchs for strong connected components reachable from a given node.
     *
     * @param root node to start from.
     */
    private func getStrongConnectedComponents(root: Int) {
        strongConnectedComponentsCounter += 1
        lowlink[root] = strongConnectedComponentsCounter
        number[root] = strongConnectedComponentsCounter
        visited[root] = true
        stack.append(root)
        
        for i in 0 ..< adjacencyList[root].reservedLength {
            guard let w = adjacencyList[root]?[i] else { continue }
            if !(visited[w] ?? false) {
                getStrongConnectedComponents(root: w);
                lowlink[root] = min(lowlink[root]!, lowlink[w]!)
            } else if let wNumber = number[w], wNumber < number[root]! {
                if stack.contains(w) {
                    lowlink[root] = min(lowlink[root]!, number[w]!)
                }
            }
        }

        // found strongConnectedComponents
        if (lowlink[root] == number[root]) && (stack.count > 0) {
            var next = -1;
            var strongConnectedComponents = [Int]()

            repeat {
                guard let popped = stack.popLast() else { break }
                next = popped
                strongConnectedComponents.append(next)
            } while number[next]! > number[root]!

            // simple scc's with just one node will not be added
            if strongConnectedComponents.count > 1 {
                currentStrongConnectedComponents.append(strongConnectedComponents);
            }
        }
    }
}
