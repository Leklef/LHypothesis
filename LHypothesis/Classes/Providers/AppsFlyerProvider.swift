//
//  AppsFlyerProvider.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 17.11.2021.
//

#if canImport(AppsFlyerLib)

import Foundation
import AppsFlyerLib

public final class AppsFlyerProvider: AnalyticsProvider {
  
  public init() {}
  
  public func logEvent(_ event: AnalyticsEvent) {
    AppsFlyerLib.shared().logEvent(
      event.name,
      withValues: event.parameters
    )
  }
  
  public func setUserId(_ userId: String?) {
    AppsFlyerLib.shared().customerUserID = userId
  }
  
}

#endif
