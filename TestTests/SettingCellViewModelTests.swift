//
//  SettingCellViewModelTests.swift
//  Test
//
//  Created by Marco Maddalena on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test

class SettingCellViewModelTests: XCTestCase {
    
    var distance: String? = ""
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: property username
    func testCellViewModelDistanceNill() {
        distance = nil
        let distanceViewModel = SettingCellViewModel(distance: distance)
        XCTAssertEqual(distanceViewModel.distanceText, "")
    }
    
    func testCellViewModelDistanceEmpty() {
        
        distance = ""
        let distanceViewModel = SettingCellViewModel(distance: distance)
        XCTAssertEqual(distanceViewModel.distanceText, "")
    }
    
    func testCellViewModelDistanceMetersOK() {
        
        distance = "100"
        let distanceViewModel = SettingCellViewModel(distance: distance)
        XCTAssertEqual(distanceViewModel.distanceText, "100 meters")
    }
    
    func testCellViewModelDistanceKmOK() {
        
        distance = "1000"
        let distanceViewModel = SettingCellViewModel(distance: distance)
        XCTAssertEqual(distanceViewModel.distanceText, "1 km")
    }
}
