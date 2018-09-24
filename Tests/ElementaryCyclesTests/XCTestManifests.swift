import XCTest
import ElementaryCycles

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ElementaryCyclesShould.allTests),
        testCase(ElementaryCyclesSearchShould.allTests),
        testCase(AdjacencyMatrixShould.allTests),
    ]
}
#endif
