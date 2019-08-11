import XCTest
import Idioms
@testable import ElementaryCyclesSearch

final class AdjacencyListTests: XCTestCase {
    static var allTests = [("testPerformance", testPerformance),
                           ("test", test)]


    let matrix = AdjacencyMatrix(5, 5) { matrix in
        for i in 0 ..< 5 {
            matrix[i][0] = true
            matrix[i][1] = false
            matrix[i][2] = true
            matrix[i][3] = false
            matrix[i][4] = true
        }
    }
    
    var sut: ((AdjacencyMatrix) -> Matrix2D<Int>)!
    
    override func setUp() {
        super.setUp()
        sut = AdjacencyList.getAdjacencyList
    }
    
    func testPerformance() {
        self.measure {
            _ = sut(matrix)
        }
    }
    
    func test() {
        let result = sut(matrix)
        let expectedDescription = "[Optional([Optional(0), Optional(2), Optional(4)]), Optional([Optional(0), Optional(2), Optional(4)]), Optional([Optional(0), Optional(2), Optional(4)]), Optional([Optional(0), Optional(2), Optional(4)]), Optional([Optional(0), Optional(2), Optional(4)])]"
        XCTAssertEqual(result.description, expectedDescription)
    }
}
