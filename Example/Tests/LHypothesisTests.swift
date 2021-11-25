import Quick
import Nimble
@testable import LHypothesis

final class LHypothesisTests: QuickSpec {
  
  override func spec() {
    describe("LHypothesis tests") {
      describe("register providers") {
        var provider = StubAnalyticsProvider()
        var provider2 = AnotherStubAnalyticsProvider()
        beforeEach {
          provider = StubAnalyticsProvider()
          provider2 = AnotherStubAnalyticsProvider()
          Analytics.removeAllProviders()
        }
        context("register providers with array") {
          it("should register all providers") {
            expect(Analytics.providers.isEmpty).to(beTrue())
            Analytics.register([provider, provider2])
            expect(Analytics.providers.count).to(equal(2))
          }
        }
        context("register provider by single property") {
          it("should register each providers") {
            expect(Analytics.providers.isEmpty).to(beTrue())
            Analytics.register(provider)
            expect(Analytics.providers.count).to(equal(1))
            Analytics.register(provider2)
            expect(Analytics.providers.count).to(equal(2))
          }
        }
        context("register by infix operator") {
          it("should register each providers in chain") {
            expect(Analytics.providers.isEmpty).to(beTrue())
            Analytics.self <<~ provider <<~ provider2
            expect(Analytics.providers.count).to(equal(2))
          }
        }
      }
      
      describe("log launch and sign in") {
        var provider = StubAnalyticsProvider()
        var provider2 = AnotherStubAnalyticsProvider()
        beforeEach {
          provider = StubAnalyticsProvider()
          provider2 = AnotherStubAnalyticsProvider()
          Analytics.removeAllProviders()
          Analytics.register([provider, provider2])
        }
        context("with provider filter") {
          it("should record 2 events for 1 provider") {
            Analytics.log(event: TestEvents.launch, providersFilter: [StubAnalyticsProvider.self])
            Analytics.log(event: TestEvents.signIn(username: "username"), providersFilter: [StubAnalyticsProvider.self])
            expect((Analytics.providers[0] as? StubAnalyticsProvider)?.loggedEvents.count).to(equal(2))
            expect((Analytics.providers[1] as? AnotherStubAnalyticsProvider)?.loggedEvents.count).to(equal(0))
          }
        }
        context("without provider filter") {
          it("should record 2 events for all providers") {
            Analytics.log(event: TestEvents.launch)
            Analytics.log(event: TestEvents.signIn(username: "username"))
            expect((Analytics.providers[0] as? StubAnalyticsProvider)?.loggedEvents.count).to(equal(2))
            expect((Analytics.providers[1] as? AnotherStubAnalyticsProvider)?.loggedEvents.count).to(equal(2))
          }
        }
      }
      
      describe("set user id") {
        var provider = StubAnalyticsProvider()
        var provider2 = AnotherStubAnalyticsProvider()
        beforeEach {
          provider = StubAnalyticsProvider()
          provider2 = AnotherStubAnalyticsProvider()
          Analytics.removeAllProviders()
          Analytics.register([provider, provider2])
        }
        context("not nil value") {
          it("should set user id") {
            Analytics.setUserId("user_id")
            expect(provider.userId).to(equal("user_id"))
            expect(provider2.userId).to(equal("user_id"))
          }
        }
        
        context("nil value") {
          it("should remove user id") {
            Analytics.setUserId(nil)
            expect(provider.userId).to(beNil())
            expect(provider2.userId).to(beNil())
          }
        }
      }
      
      describe("set user properties") {
        var provider = StubAnalyticsProvider()
        var provider2 = AnotherStubAnalyticsProvider()
        beforeEach {
          provider = StubAnalyticsProvider()
          provider2 = AnotherStubAnalyticsProvider()
          Analytics.removeAllProviders()
          Analytics.register([provider, provider2])
        }
        it("should add user properites to analytics") {
          Analytics.setUserProperty("18", forName: "age")
          Analytics.setUserProperty(nil, forName: "gender")
          Analytics.setUserProperty("hobby", forName: "football", providersFilter: [StubAnalyticsProvider.self])
          
          expect(provider.userProperties.count).to(equal(3))
          expect(provider2.userProperties.count).to(equal(2))
          expect(provider.userProperties["football"]).to(equal("hobby"))
        }
      }
    }
    
    describe("AnalyticsProvider tests") {
      describe("get provider's name") {
        it("should return class name") {
          let provider = StubAnalyticsProvider()
          expect(provider.name).to(equal("StubAnalyticsProvider"))
        }
      }
    }
  }
}

enum TestEvents {
  case launch
  case signIn(username: String)
}

extension TestEvents: AnalyticsEvent {
  
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

class StubAnalyticsProvider: AnalyticsProvider {
  
  var loggedEvents = [AnalyticsEvent]()
  var userId: String? = nil
  var userProperties = [String: String?]()
  
  func logEvent(_ event: AnalyticsEvent) {
    loggedEvents.append(event)
  }
  
  func setUserId(_ userId: String?) {
    self.userId = userId
  }
  
  func setUserProperty(_ property: String?, forName name: String) {
    userProperties[name] = property
  }
  
}

final class AnotherStubAnalyticsProvider: StubAnalyticsProvider {}
