//
//  AnalyticsProviderMock.swift
//  LHypothesisTests
//
//  Created by Ленар Гилязов on 04.04.2023.
//

import Foundation
#if canImport(LHypothesis_iOS)
@testable import LHypothesis_iOS
#else
@testable import LHypothesis
#endif

class AnalyticsProviderMock: AnalyticsProvider {

    var invokedLogEvent = false
    var invokedLogEventCount = 0
    var invokedLogEventParameters: (event: AnalyticsEvent, Void)?
    var invokedLogEventParametersList = [(event: AnalyticsEvent, Void)]()

    func logEvent(_ event: AnalyticsEvent) {
        invokedLogEvent = true
        invokedLogEventCount += 1
        invokedLogEventParameters = (event, ())
        invokedLogEventParametersList.append((event, ()))
    }

    var invokedSetUserId = false
    var invokedSetUserIdCount = 0
    var invokedSetUserIdParameters: (userId: String?, Void)?
    var invokedSetUserIdParametersList = [(userId: String?, Void)]()

    func setUserId(_ userId: String?) {
        invokedSetUserId = true
        invokedSetUserIdCount += 1
        invokedSetUserIdParameters = (userId, ())
        invokedSetUserIdParametersList.append((userId, ()))
    }

    var invokedSetUserProperty = false
    var invokedSetUserPropertyCount = 0
    var invokedSetUserPropertyParameters: (property: String?, name: String)?
    var invokedSetUserPropertyParametersList = [(property: String?, name: String)]()

    func setUserProperty(_ property: String?, forName name: String) {
        invokedSetUserProperty = true
        invokedSetUserPropertyCount += 1
        invokedSetUserPropertyParameters = (property, name)
        invokedSetUserPropertyParametersList.append((property, name))
    }
}
