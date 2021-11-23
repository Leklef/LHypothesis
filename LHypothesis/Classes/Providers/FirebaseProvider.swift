//
//  FirebaseProvider.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 17.11.2021.
//

#if canImport(FirebaseAnalytics)

import Foundation
import FirebaseAnalytics

public final class FirebaseProvider: AnalyticsProvider {
  
  public init() {}
  
  public func logEvent(_ event: AnalyticsEvent) {
    FirebaseAnalytics.Analytics.logEvent(event.name, parameters: event.parameters)
  }
  
  public func setUserId(_ userId: String?) {
    FirebaseAnalytics.Analytics.setUserID(userId)
  }
  
}

#endif
