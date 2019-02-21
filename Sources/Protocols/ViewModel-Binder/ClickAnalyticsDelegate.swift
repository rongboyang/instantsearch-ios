//
//  ClickAnalyticsDelegate.swift
//  InstantSearch
//
//  Created by Vladislav Fitc on 18/02/2019.
//

import Foundation
import InstantSearchInsights

public protocol ClickAnalyticsDelegate: class {
    
    func clickedAfterSearch(eventName: String,
                            indexName: String,
                            objectID: String,
                            position: Int,
                            queryID: String)
    
    func clicked(eventName: String,
                 indexName: String,
                 filters: [String])
    
}

extension Insights: ClickAnalyticsDelegate {
    
    public func clickedAfterSearch(eventName: String,
                                   indexName: String,
                                   objectID: String,
                                   position: Int,
                                   queryID: String) {
        clickedAfterSearch(eventName: eventName,
                           indexName: indexName,
                           objectID: objectID,
                           position: position,
                           queryID: queryID,
                           userToken: .none)
    }
    
    public func clicked(eventName: String,
                        indexName: String,
                        filters: [String]) {
        clicked(eventName: eventName,
                indexName: indexName,
                filters: filters,
                userToken: .none)
    }
}
