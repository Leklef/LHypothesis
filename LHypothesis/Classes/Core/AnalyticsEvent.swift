//
//  AnalyticsEvent.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 16.11.2021.
//

public typealias AnalyticsEventParameters = [String: Any]

public protocol AnalyticsEvent {
  var name: String { get }
  var parameters: AnalyticsEventParameters? { get }
}
