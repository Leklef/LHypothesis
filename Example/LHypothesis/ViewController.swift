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
    
    var userProperties: AnalyticsEventUserProperties? {
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
        Analytics.shared.register([FirebaseProvider(), AppsFlyerProvider()])
      
        // 2: Log event (by default log event for all providers)
        Analytics.shared.log(event: TestAnalyticsEvent.viewDidLoad)
      
        // 2 `optional`: Log event for some providers
        Analytics.shared.log(event: TestAnalyticsEvent.viewDidLoad, providersFilter: [FirebaseProvider.self])
    }

}

