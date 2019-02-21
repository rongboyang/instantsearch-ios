//
//  RefinementViewModelAnalyticsTests.swift
//  InstantSearch
//
//  Created by Vladislav Fitc on 21/02/2019.
//

import Foundation

import XCTest
@testable import InstantSearch
import InstantSearchCore
import InstantSearchClient

class RefinementViewModelAnalyticsTests: XCTestCase {

    override func setUp() {
        InstantSearch.shared.configure(appID: "appID", apiKey: "apiKey", index: "testIndex")
    }

    func testNumericControlViewModelEventCapturing() {
        
        let exp = expectation(description: #function)
        
        let widget = DatePickerWidget(frame: .zero)
        widget.enableClickAnalytics = true
        widget.index = "testIndex"
        widget.clickEventName = "testEventName"
        widget.attribute = "startDate"
        widget.operator = "=="
        
        widget.set(value: NSNumber(value: 1000))
        
        let viewModel = NumericControlViewModel(view: widget)
        let searcher = InstantSearch.shared.getSearcher()
        widget.viewModel = viewModel
        viewModel.configure(with: searcher)
        
        let caTestHelper = TestClickAnalyticsHelper()
        
        caTestHelper.filterHandler = { eventName, indexName, filters in
            XCTAssertEqual(eventName, "testEventName")
            XCTAssertEqual(indexName, "testIndex")
            XCTAssertEqual(filters, ["\"startDate\" = 2000"])
            exp.fulfill()
        }
        
        viewModel.clickAnalyticsDelegate = caTestHelper
        
        viewModel.updateNumeric(value: NSNumber(value: 2000), doSearch: false)
        
        waitForExpectations(timeout: 2, handler: .none)
        
    }
    
    func testFacetControlViewModelEventCapturing() {
        
        let exp = expectation(description: #function)
        
        let widget = OneValueSwitchWidget(frame: .zero)
        widget.enableClickAnalytics = true
        widget.index = "testIndex"
        widget.clickEventName = "testEventName"
        widget.attribute = "isFeatured"
        
        widget.valueOn = "true"
        widget.isOn = true
        
        let viewModel = FacetControlViewModel(view: widget)
        let searcher = InstantSearch.shared.getSearcher()
        widget.viewModel = viewModel
        viewModel.configure(with: searcher)
        
        let caTestHelper = TestClickAnalyticsHelper()
        
        caTestHelper.filterHandler = { eventName, indexName, filters in
            XCTAssertEqual(eventName, "testEventName")
            XCTAssertEqual(indexName, "testIndex")
            XCTAssertEqual(filters, ["\"isFeatured\":\"false\""])
            exp.fulfill()
        }
        
        viewModel.clickAnalyticsDelegate = caTestHelper
        
        viewModel.updateFacet(oldValue: "true", newValue: "false", doSearch: false)
        
        waitForExpectations(timeout: 2, handler: .none)
        
    }
    
    func testRefinementMenuViewModelEventCapturing() {
        
        let exp = expectation(description: #function)
        
        let widget = RefinementTableWidget(frame: .zero, style: .plain)
        widget.enableClickAnalytics = true
        widget.index = "testIndex"
        widget.clickEventName = "testEventName"
        widget.attribute = "category"
        
        let viewModel = RefinementMenuViewModel(view: widget)
        let searcher = InstantSearch.shared.getSearcher()
        widget.viewModel = viewModel
        viewModel.configure(with: searcher)
        viewModel.facetResults = [
            FacetValue(value: "Cat1", count: 100),
            FacetValue(value: "Cat2", count: 100),
            FacetValue(value: "Cat3", count: 100)
        ]
        
        let caTestHelper = TestClickAnalyticsHelper()
        
        caTestHelper.filterHandler = { eventName, indexName, filters in
            XCTAssertEqual(eventName, "testEventName")
            XCTAssertEqual(indexName, "testIndex")
            XCTAssertEqual(filters, ["category:Cat2"])
            exp.fulfill()
        }
        
        viewModel.clickAnalyticsDelegate = caTestHelper
        
        viewModel.didSelectRow(at: IndexPath(row: 1, section: 0))
        
        waitForExpectations(timeout: 2, handler: .none)
        
    }

    
}
