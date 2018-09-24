import XCTest

import ElementaryCyclesSearchTests

var tests = [XCTestCaseEntry]()
tests += ElementaryCyclesSearchTests.allTests()
tests += ElementaryCyclesTests.allTests()
XCTMain(tests)
