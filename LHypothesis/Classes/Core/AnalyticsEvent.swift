//
//  AnalyticsEvent.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 16.11.2021.
//

public typealias AnalyticsEventParameters = [String: Any]
public typealias AnalyticsEventUserProperties = [String: String]

public protocol AnalyticsEvent {
  var name: String { get }
  var parameters: AnalyticsEventParameters? { get }
  var userProperties: AnalyticsEventUserProperties? { get }
}
