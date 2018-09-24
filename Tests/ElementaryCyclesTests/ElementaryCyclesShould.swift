import XCTest
@testable import ElementaryCycles
@testable import ElementaryCyclesSearch

final class ElementaryCyclesShould: XCTestCase {
    static var allTests = [("test_find_cycles", test_find_cycles),
                           ("test_find_sorted_cycles", test_find_sorted_cycles)]

    func test_find_cycles() {
        let graph = ["0": ["1"], "1": ["2", "0"], "2": []]
        let result = ElementaryCycles.find(graph: graph)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.count, 2)
        XCTAssertEqual(result.first?.contains("0"), true)
        XCTAssertEqual(result.first?.contains("1"), true)
    }

    func test_find_sorted_cycles() {
        let graph = ["A": ["B", "C"], "B": ["A"], "C": ["D"], "D": ["C"]]
        let result = ElementaryCycles.find(graph: graph, sort: { $0 < $1 })
        let expected = [["A", "B"], ["C", "D"]]
        XCTAssertEqual(result, expected)
    }
}
