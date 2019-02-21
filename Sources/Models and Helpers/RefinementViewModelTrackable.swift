//
//  RefinementViewModelTrackable.swift
//  InstantSearch
//
//  Created by Vladislav Fitc on 21/02/2019.
//

import Foundation

protocol RefinementViewModelTrackable {
    
    var trackableView: (ClickAnalyticsTrackable & AlgoliaIndexWidget)? { get }
    var clickAnalyticsDelegate: ClickAnalyticsDelegate? { get }
    
    func trackClickOf(filters: [String])
    
}

extension RefinementViewModelTrackable {
    
    func trackClickOf(filters: [String]) {
        guard
            let trackableView = trackableView,
            let eventName = trackableView.clickEventName,
            trackableView.enableClickAnalytics else { return }
        clickAnalyticsDelegate?.clicked(eventName: eventName, indexName: trackableView.index, filters: filters)
    }
    
}
