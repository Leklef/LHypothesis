//
//  AppsFlyerProvider.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 17.11.2021.
//

#if canImport(AppsFlyerLib)
import Foundation
import AppsFlyerLib
#if SWIFT_PACKAGE
import LHypothesis
#endif

public final class AppsFlyerProvider: AnalyticsProvider {
    
    public init() {}
    
    // MARK: - AnalyticsProvider
    
    public func logEvent(_ event: AnalyticsEvent) {
        AppsFlyerLib.shared().logEvent(
            event.name,
            withValues: event.parameters
        )
    }
    
    public func setUserId(_ userId: String?) {
        AppsFlyerLib.shared().customerUserID = userId
    }
    
    public func setUserProperty(_ property: String?, forName name: String) {
        // AppsFlyer doesn't provide this function
    }
}
#endif
