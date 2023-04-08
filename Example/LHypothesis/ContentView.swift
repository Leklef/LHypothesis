//
//  ContentView.swift
//  LHypothesis
//
//  Created by Lenar Gilyazov on 08.04.2023.
//

import SwiftUI
import LHypothesis

enum TestAnalyticsEvent: AnalyticsEvent {
  
    case onAppear
    
    var name: String {
        switch self {
        case .onAppear:
          return "onAppear"
        }
    }
    
    var parameters: AnalyticsEventParameters? {
        switch self {
        case .onAppear:
          return nil
        }
    }
  
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // 1: Register providers
            Analytics.self <<~ FirebaseProvider() <<~ AppsFlyerProvider()
            // or
            //Analytics.register([FirebaseProvider(), AppsFlyerProvider()])
            
            // 2 `optional`: Set user properties
            Analytics.setUserProperty("18", forName: "age")
            
            // 3: Log event (by default log event for all providers)
            Analytics.log(event: TestAnalyticsEvent.onAppear)
            
            // 3 `optional`: Log event for some providers
            Analytics.log(event: TestAnalyticsEvent.onAppear, providersFilter: [FirebaseProvider.self])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
