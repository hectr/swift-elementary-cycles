import XCTest
import ElementaryCyclesSearch

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AdjacencyListTests.allTests),
        testCase(ElementaryCyclesSearchTests.allTests),
        testCase(AdjacencyMatrixTests.allTests),
        testCase(StrongConnectedComponentsTests.allTests),
    ]
}
#endif
