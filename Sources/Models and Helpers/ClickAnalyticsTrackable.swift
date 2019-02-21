//
//  ClickAnalyticsTrackable.swift
//  InstantSearch
//
//  Created by Vladislav Fitc on 20/02/2019.
//

import Foundation

@objc public protocol ClickAnalyticsTrackable {
    
    /// Whetever or not Click Analytics activated for this widget
    var enableClickAnalytics: Bool { get set }
    
    /// Analytics event name for click used by Insights
    /// - Note: Event will not be sent if this field left nil
    var clickEventName: String? { get set }
    
}
