import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(mutini_autographTests.allTests),
    ]
}
#endif
