import XCTest
#if canImport(LHypothesis_iOS)
@testable import LHypothesis_iOS
#else
@testable import LHypothesis
#endif

final class AnalyticsTests: XCTestCase {
    
    // MARK: - Life cycle
    
    override func tearDownWithError() throws {
        Analytics.removeAllProviders()
        try super.tearDownWithError()
    }
    
    // MARK: - Test cases
    
    func test_registerProviders_whenRegisterArray_shouldRegisterAllProviders() throws {
        // given
        let provider1 = AnalyticsProviderMock()
        let provider2 = AnalyticsProviderMock()
        
        // when
        Analytics.register([provider1, provider2])
        
        // then
        XCTAssertIdentical(Analytics.providers[0], provider1)
        XCTAssertIdentical(Analytics.providers[1], provider2)
    }
    
    func test_registerProvider_whenRegisterSingleProvider_shouldRegisterThem() throws {
        // given
        let provider1 = AnalyticsProviderMock()
        let provider2 = AnalyticsProviderMock()
        
        // when
        Analytics.register(provider1)
        Analytics.register(provider2)
        
        // then
        XCTAssertIdentical(Analytics.providers[0], provider1)
        XCTAssertIdentical(Analytics.providers[1], provider2)
    }
    
    func test_registerProvider_whenRegisterByInfixOperator_shouldRegisterProviders() throws {
        // given
        let provider1 = AnalyticsProviderMock()
        let provider2 = AnalyticsProviderMock()
        
        // when
        Analytics.self <<~ provider1 <<~ provider2
        
        // then
        XCTAssertIdentical(Analytics.providers[0], provider1)
        XCTAssertIdentical(Analytics.providers[1], provider2)
    }
    
    func test_logEvent_whenLogWithProvidersFilter_shouldSentEventsToProviders() throws {
        // given
        final class AlternativeAnalyticsProviderMock: AnalyticsProviderMock {}
        let provider1 = AnalyticsProviderMock()
        let provider2 = AlternativeAnalyticsProviderMock()
        Analytics.register([provider1, provider2])
        
        // when
        Analytics.log(event: TestEvents.launch,
                      providersFilter: [AnalyticsProviderMock.self])
        Analytics.log(event: TestEvents.signIn(username: "username"),
                      providersFilter: [AlternativeAnalyticsProviderMock.self])
        
        // then
        XCTAssertEqual(
            provider1.invokedLogEventParameters?.event as? TestEvents,
            TestEvents.launch
        )
        XCTAssertEqual(
            provider2.invokedLogEventParameters?.event as? TestEvents,
            TestEvents.signIn(username: "username")
        )
    }
    
    func test_logEvent_whenLogWithoutProvidersFilter_shouldSentEventsToProviders() throws {
        // given
        final class AlternativeAnalyticsProviderMock: AnalyticsProviderMock {}
        let provider1 = AnalyticsProviderMock()
        let provider2 = AlternativeAnalyticsProviderMock()
        Analytics.register([provider1, provider2])
        
        // when
        Analytics.log(event: TestEvents.launch)
        Analytics.log(event: TestEvents.signIn(username: "username"))
        
        // then
        XCTAssertEqual(
            provider1.invokedLogEventParametersList.first?.event as? TestEvents,
            TestEvents.launch
        )
        XCTAssertEqual(
            provider2.invokedLogEventParametersList.first?.event as? TestEvents,
            TestEvents.launch
        )
    }
    
    func test_setUserID_shouldSetUserIDToProvider() throws {
        // given
        let expectedUserID = "user_id"
        let provider1 = AnalyticsProviderMock()
        let provider2 = AnalyticsProviderMock()
        Analytics.register([provider1, provider2])
        
        // when
        Analytics.setUserId(expectedUserID)
        
        // then
        XCTAssertEqual(provider1.invokedSetUserIdParameters?.userId, expectedUserID)
        XCTAssertEqual(provider2.invokedSetUserIdParameters?.userId, expectedUserID)
    }
    
    func test_setUserProperties_shouldAddUserPropertiesToAnalytics() throws {
        // given
        final class AlternativeAnalyticsProviderMock: AnalyticsProviderMock {}
        let provider1 = AnalyticsProviderMock()
        let provider2 = AlternativeAnalyticsProviderMock()
        Analytics.register([provider1, provider2])
        
        // when
        Analytics.setUserProperty("18", forName: "age")
        Analytics.setUserProperty(nil, forName: "gender")
        Analytics.setUserProperty("hobby", forName: "football", providersFilter: [AnalyticsProviderMock.self])
        
        // then
        XCTAssertEqual(provider1.invokedSetUserPropertyCount, 3)
        XCTAssertEqual(provider2.invokedSetUserPropertyCount, 2)
        XCTAssertEqual(
            provider1.invokedSetUserPropertyParametersList.filter { $0.name == "football" }.first?.property,
            "hobby"
        )
    }
}

// MARK: - TestEvents

enum TestEvents: AnalyticsEvent, Equatable {
    case launch
    case signIn(username: String)
    
    var name: String {
        switch self {
        case .launch:
            return "launch"
        case .signIn:
            return "signIn"
        }
    }
    
    var parameters: AnalyticsEventParameters? {
        switch self {
        case .launch: return nil
        case .signIn(let username): return ["username": username]
        }
    }
}
