import XCTest
@testable import ElementaryCyclesSearch

final class AdjacencyMatrixTests: XCTestCase {
    static var allTests = [("test", test),
                           ("testConvenienceInit", testConvenienceInit),
                           ("testSequence", testSequence)
    ]
    
    func test() {
        let sut = AdjacencyMatrix(5, 5)
        for i in 0 ..< 5 {
            sut[i][0] = true
            sut[i][1] = false
            sut[i][2] = true
            sut[i][3] = false
            sut[i][4] = true
        }
        let expectedDescription = "[Optional([Optional(true), Optional(false), Optional(true), Optional(false), Optional(true)]), Optional([Optional(true), Optional(false), Optional(true), Optional(false), Optional(true)]), Optional([Optional(true), Optional(false), Optional(true), Optional(false), Optional(true)]), Optional([Optional(true), Optional(false), Optional(true), Optional(false), Optional(true)]), Optional([Optional(true), Optional(false), Optional(true), Optional(false), Optional(true)])]"
        XCTAssertEqual(sut.description, expectedDescription)
    }

    func testConvenienceInit() {
        let rows = [["a"],[],["b", "c"]]
        let matrix = Matrix<String>(rows: rows)
        let expectedMatrix: Matrix<String> = {
            let matrix = Matrix<String>(3, 2)
            matrix[0][0] = "a"
            matrix[2][0] = "b"
            matrix[2][1] = "c"
            return matrix
        }()
        XCTAssertEqual(matrix, expectedMatrix)
    }

    func testSequence() {
        let matrix = Matrix<Int>(4, 4)
        matrix[0][1] = 1
        matrix[1][2] = 2
        matrix[3][0] = 3
        matrix[3][3] = 4
        var elements = [Int]()
        for element in matrix {
            elements.append(element)
        }
        let expectedElements = [1,2,3, 4]
        XCTAssertEqual(elements, expectedElements)
    }
}
