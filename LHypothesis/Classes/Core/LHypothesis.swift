//
//  LHypothesis.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 16.11.2021.
//

import Foundation

public enum Analytics {
  
  static var providers: [AnalyticsProvider] = []
  
  public static func register(_ provider: AnalyticsProvider) {
    Self.providers.append(provider)
  }
  
  public static func register(_ providers: [AnalyticsProvider]) {
    Self.providers.append(contentsOf: providers)
  }
  
  public static func removeAllProviders() {
    Self.providers = []
  }
  
  public static func log(event: AnalyticsEvent, providersFilter: [AnalyticsProvider.Type] = []) {
    if providersFilter.isEmpty {
      Self.providers.forEach {
        $0.logEvent(event)
      }
    } else {
      Self.providers.filter { provider in providersFilter.contains(where: { type(of: provider as Any) == $0 }) }.forEach {
        $0.logEvent(event)
      }
    }
  }
  
  public static func setUserProperty(_ property: String?, forName name: String, providersFilter: [AnalyticsProvider.Type] = []) {
    if providersFilter.isEmpty {
      Self.providers.forEach {
        $0.setUserProperty(property, forName: name)
      }
    } else {
      Self.providers.filter { provider in providersFilter.contains(where: { type(of: provider as Any) == $0 }) }.forEach {
        $0.setUserProperty(property, forName: name)
      }
    }
  }
  
  public static func setUserId(_ userId: String?) {
    Self.providers.forEach {
      $0.setUserId(userId)
    }
  }
  
}

precedencegroup AnalyticalPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}

infix operator <<~: AnalyticalPrecedence

@discardableResult
public func <<~ (left: Analytics.Type, right: AnalyticsProvider) -> Analytics.Type {
  left.register(right)
  return left
}
