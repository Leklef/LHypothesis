import XCTest
#if canImport(LHypothesis_iOS)
@testable import LHypothesis_iOS
#else
@testable import LHypothesis
#endif

final class AnalyticsProviderTests: XCTestCase {

    func test_getName_shouldReturnClassName() throws {
        // given
        let sut = AnalyticsProviderMock()
        
        // when
        let result = sut.name
        
        // then
        XCTAssertEqual(result, "AnalyticsProviderMock")
    }
}
