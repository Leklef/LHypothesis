//
//  ViewController.swift
//  LHypothesis
//
//  Created by lenar-craftmaster on 11/16/2021.
//  Copyright (c) 2021 lenar-craftmaster. All rights reserved.
//

import UIKit
import LHypothesis

enum TestAnalyticsEvent: AnalyticsEvent {
  
    case viewDidLoad
    
    var name: String {
        switch self {
        case .viewDidLoad:
          return "viewDidLoad"
        }
    }
    
    var parameters: AnalyticsEventParameters? {
        switch self {
        case .viewDidLoad:
          return nil
        }
    }
  
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 1: Register providers
        Analytics.self <<~ FirebaseProvider() <<~ AppsFlyerProvider()
        // or
        //Analytics.register([FirebaseProvider(), AppsFlyerProvider()])
      
        // 2 `optional`: Set user properties
        Analytics.setUserProperty("18", forName: "age")
      
        // 3: Log event (by default log event for all providers)
        Analytics.log(event: TestAnalyticsEvent.viewDidLoad)
      
        // 3 `optional`: Log event for some providers
        Analytics.log(event: TestAnalyticsEvent.viewDidLoad, providersFilter: [FirebaseProvider.self])
    }

}

