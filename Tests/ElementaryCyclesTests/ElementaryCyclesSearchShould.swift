import XCTest
@testable import ElementaryCycles
@testable import ElementaryCyclesSearch

final class ElementaryCyclesSearchShould: XCTestCase {
    static var allTests = [("test_map_cycles_to_array", test_map_cycles_to_array)]

    private typealias Node = String
    
    private var nodes: Array<Node> {
        var nodes = Array<Node>()
        for i in 0 ..< 10 {
            nodes.append("Node \(i)")
        }
        return nodes
    }
    
    private var adjacencyMatrix = AdjacencyMatrix(10, 10) { matrix in
        matrix[0][1] = true
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
        matrix[9][6] = true
    }
    
    func test_map_cycles_to_array() {
        let result = ElementaryCyclesSearch.toArray(elementaryCycles: ElementaryCyclesSearch.getElementaryCycles(adjacencyMatrix: adjacencyMatrix, graphNodes: nodes))
        let expected = [["Node 0", "Node 1", "Node 2"], ["Node 3", "Node 6", "Node 5"], ["Node 6", "Node 7", "Node 9"]]
        XCTAssertEqual(result, expected)
    }
}
