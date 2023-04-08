import XCTest
@testable import LHypothesis

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
