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

protocol AnalyticsServies {
    func sendEvent(_ event: AnalyticsEvents, _ detail: String?)
}

extension AnalyticsServies {
    func sendEvent(_ event: AnalyticsEvents, _ detail: String? = nil) {
        sendEvent(event, detail)
    }
}

final class GoogleAnalyticsWrapper: AnalyticsServies {
    func sendEvent(_ event: AnalyticsEvents, _ detail: String) {
        Analytics.logEvent(event.rawValue, parameters: ["page subject": detail])
    }
}
