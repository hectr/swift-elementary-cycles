import XCTest
@testable import ElementaryCycles
@testable import ElementaryCyclesSearch

final class AdjacencyMatrixShould: XCTestCase {
    static var allTests = [("test_build_adjacency_matrix_from_dictionary", test_build_adjacency_matrix_from_dictionary),
                           ("test_build_nodes_vector_from_array", test_build_nodes_vector_from_array)]

    func test_build_adjacency_matrix_from_dictionary() {
        let nodes = ["ES", "PT", "FR", "IT"]
        let adjacencies = ["ES": ["PT", "FR"],
                           "PT": ["ES"],
                           "FR": ["ES", "IT"],
                           "IT": ["FR"]]
        let adjacencyMatrix = try! AdjacencyMatrix.getAdjacencyMatrix(nodes: nodes, adjacencyDictionary: adjacencies)
        let expectedAdjacencyMatrix = AdjacencyMatrix(4, 4) { matrix in
            matrix[0][1] = true
            matrix[0][2] = true
            matrix[1][0] = true
            matrix[2][0] = true
            matrix[2][3] = true
            matrix[3][2] = true
        }
        XCTAssertEqual(adjacencyMatrix, expectedAdjacencyMatrix)
    }

    func test_build_nodes_vector_from_array() {
        let graph = ["ES": ["PT", "FR"],
                     "PT": ["ES"],
                     "FR": ["ES", "IT"],
                     "IT": ["FR"]]
        let nodes = AdjacencyMatrix.getNodes(graph: graph, sort: nil)
        let adjacencyMatrix = try! AdjacencyMatrix.getAdjacencyMatrix(nodes: nodes, adjacencyDictionary: graph)
        let es = nodes.firstIndex(of: "ES")!
        let pt = nodes.firstIndex(of: "PT")!
        let fr = nodes.firstIndex(of: "FR")!
        let it = nodes.firstIndex(of: "IT")!
        XCTAssertTrue(adjacencyMatrix[es][pt] ?? adjacencyMatrix[pt][es] ?? false)
        XCTAssertTrue(adjacencyMatrix[es][fr] ?? adjacencyMatrix[fr][es] ?? false)
        XCTAssertTrue(adjacencyMatrix[fr][it] ?? adjacencyMatrix[it][fr] ?? false)
        XCTAssertFalse(adjacencyMatrix[es][it] ?? adjacencyMatrix[it][es] ?? false)
        XCTAssertFalse(adjacencyMatrix[pt][it] ?? adjacencyMatrix[it][pt] ?? false)
        XCTAssertFalse(adjacencyMatrix[fr][pt] ?? adjacencyMatrix[pt][fr] ?? false)
    }
}
