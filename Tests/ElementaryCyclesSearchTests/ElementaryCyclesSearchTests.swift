import XCTest
@testable import ElementaryCyclesSearch

final class ElementaryCyclesSearchTests: XCTestCase {
    static var allTests = [("test", test)]

    private typealias Node = String
    
    private var nodes: Vector<Node> {
        let nodes = Vector<Node>(10)
        for i in 0 ..< 10 {
            nodes[i] = "Node \(i)"
        }
        return nodes
    }
    
    private let adjacencyMatrix = AdjacencyMatrix(10, 10) { matrix in
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
    
    private var sut: ((AdjacencyMatrix, Vector<Node>) -> Vector<Vector<Node>>)!
    
    private func prettify(cycles: Vector<Vector<Node>>) -> String {
        var description = ""
        for i in 0 ..< cycles.size {
            let cycle = cycles.get(i)
            for j in 0 ..< cycle.size {
                let node = cycle.get(j)
                if j < (cycle.size - 1) {
                    description.append(node + " -> ")
                } else {
                    description.append(node)
                }
            }
            description.append("\n")
        }
        return description
    }
    
    override func setUp() {
        super.setUp()
        sut = ElementaryCyclesSearch.getElementaryCycles
    }
    
    func testPerformanceExample() {
        self.measure {
            _ = sut(adjacencyMatrix, nodes)
        }
    }
    
    func test() {
        let adjacencyMatrix: AdjacencyMatrix = {
            let matrix = AdjacencyMatrix(10, 10)
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
            return matrix
        }()
        let result = sut(adjacencyMatrix, nodes)
        let description = prettify(cycles: result)
        let expectedString =
"""
Node 0 -> Node 1 -> Node 2
Node 1 -> Node 2 -> Node 6
Node 3 -> Node 4 -> Node 5
Node 6 -> Node 7 -> Node 8

"""
        XCTAssertEqual(description, expectedString)
    }
}
