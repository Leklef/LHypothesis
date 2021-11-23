//
//  AnalyticsProvider.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 16.11.2021.
//

public protocol AnalyticsProvider {
  var name: String { get }
  
  func logEvent(_ event: AnalyticsEvent)
  func setUserId(_ userId: String?)
}

extension AnalyticsProvider {
  
  public var name: String {
    String(describing: self)
  }
  
}
