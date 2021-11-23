//
//  LHypothesis.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 16.11.2021.
//

import Foundation

public final class Analytics {
  
  public static let shared = Analytics()
  
  private var providers: [AnalyticsProvider] = []
  
  private init() {}
  
  public func register(_ provider: AnalyticsProvider) {
    self.providers.append(provider)
  }
  
  public func register(_ providers: [AnalyticsProvider]) {
    self.providers.append(contentsOf: providers)
  }
  
  public func log(event: AnalyticsEvent, providersFilter: [AnalyticsProvider.Type] = []) {
    if providersFilter.isEmpty {
      providers.forEach {
        $0.logEvent(event)
      }
    } else {
      providers.filter { provider in providersFilter.contains(where: { type(of: provider as Any) == $0 }) }.forEach {
        $0.logEvent(event)
      }
    }
  }
  
  public func setUserId(_ userId: String?) {
    providers.forEach {
      $0.setUserId(userId)
    }
  }
  
}

precedencegroup AnalyticalPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}

infix operator <<~: AnalyticalPrecedence

public func <<~ (left: Analytics, right: AnalyticsProvider) -> Analytics {
  left.register(right)
  return left
}
