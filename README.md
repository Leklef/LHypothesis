# LHypothesis

[![Build Status](https://app.travis-ci.com/lgilyazov/LHypothesis.svg?branch=master)](https://app.travis-ci.com/lgilyazov/LHypothesis)
[![codecov](https://codecov.io/gh/lgilyazov/LHypothesis/branch/master/graph/badge.svg?token=QVZQQB91ZJ)](https://codecov.io/gh/lgilyazov/LHypothesis)
[![Version](https://img.shields.io/cocoapods/v/LHypothesis.svg?style=flat)](https://cocoapods.org/pods/LHypothesis)
[![License](https://img.shields.io/cocoapods/l/LHypothesis.svg?style=flat)](https://cocoapods.org/pods/LHypothesis)
[![Platform](https://img.shields.io/cocoapods/p/LHypothesis.svg?style=flat)](https://cocoapods.org/pods/LHypothesis)

Analytics abstraction layer for Swift.

## Table of Contents

* [Example](#example)
* [Installation](#installation)
    * [CocoaPods](#cocoapods)
    * [Swift Package Manager](#swift-package-manager)
* [Getting started](#getting-started)
    * [Defining Events](#defining-events)
    * [Usage](#usage)
    * [Built-in Providers](#built-in-providers)
    * [Custom Providers](#custom-providers)
* [License](#license)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

LHypothesis is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LHypothesis'
pod 'LHypothesis/Firebase' # using with built-in FirebaseProvider
pod 'LHypothesis/AppsFlyer' # using with built-in AppsFlyerProvider
```

### Swift Package Manager

Also you can install LHypothesis via the Swift Package Manager

## Getting started

### Defining Events

First of all, you should define all of your events in a enums.

```swift
enum AuthEvent {
  case signup(username: String)
  case signin(username: String)
  case resetPassword(username: String)
}

enum PurchaseEvents {
  case purchase(productID: Int, price: Float)
  case requestPrice(productID: Int)
}
```

Then make the enum to conform the protocol `AnalyticsEvent`. It requires three variables: `name`, `parameters` and `userProperties`.

```swift
extension PurchaseEvents: AnalyticsEvent {
  /// An event name to be logged
  var name: String {
    switch self {
    case .purchase: return "purchase"
    case .requestPrice: return "request_price"
    }
  }

  /// Parameters to be logged
  var parameters: AnalyticsEventParameters? {
    switch self {
    case let .purchase(productID, price):
      return ["product_id": productID, "price": price]
    case .requestPrice(let productID): 
      return ["product_id": productID]
    }
  }

}
```

### Usage

First of all, you should register providers. A prodiver is a wrapper for an actual analytics service such as Firebase and Fabric Answers. It's recommended to register providers in `application(_:didFinishLaunchingWithOptions:)`.

```swift
Analytics.register([FirebaseProvider(), AppsFlyerProvider()])
```

Then you can log the events:

```swift
Analytics.log(event: .purchase(providerID: 1, price: 12.0))
```

This method log events for all providers. If you want to log an events for specific providers, use the `providersFilter`

```swift
Analytics.log(event: .purchase(providerID: 1, price: 12.0), providersFilter: [FirebaseProvider.self])
```

### Built-in Providers

* FirebaseProvider ([Firebase/Analytics](https://cocoapods.org/pods/Firebase))
* AppsFlyerProvider ([AppsFlyerFramework](https://cocoapods.org/pods/AppsFlyerFramework))

### Custom Providers

If there's no built-in provider for the serivce you're using, you can also create your own. It's easy to create a provider: just create a class and conform to the protocol `AnalyticsProvider`.

```swift
class MyAnalyticsProvider: AnalyticsProvider {
  
  func logEvent(_ event: AnalyticsEvent) {
    Analytics.logEvent(event.name, parameters: event.parameters)
  }
  
  public func setUserProperty(_ property: String?, forName name: String) {
    Analytics.setUserProperty(property, forName: name)
  }
  
  func setUserId(_ userId: String?) {
    Analytics.setUserID(userId)
  }
}
```

## License

LHypothesis is available under the MIT license. See the LICENSE file for more info.
