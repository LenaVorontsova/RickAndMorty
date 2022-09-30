//
//  GoogleAnalyticsWrapper.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 29.09.2022.
//

import Foundation
import FirebaseAnalytics

enum AnalyticsEvents: String {
    case detailPage
}

protocol AnalyticsServie {
    func sendEvent(_ event: AnalyticsEvents, _ detail: String)
}

final class GoogleAnalyticsWrapper: AnalyticsServie {
    func sendEvent(_ event: AnalyticsEvents, _ detail: String) {
        Analytics.logEvent(event.rawValue, parameters: ["page subject": detail])
    }
}
