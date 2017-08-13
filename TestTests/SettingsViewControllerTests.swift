//
//  SettingsViewControllerTests.swift
//  Test
//
//  Created by Marco Maddalena on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test

class SettingsViewControllerTests: XCTestCase {
    
    var settingsViewController: SettingsViewController!
    var provider: SettingsProvider = SettingsProvider.sharedInstance
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        let distaces: [String] = ["100","200","500","1000","2000","3000","4000","5000"]
        provider.distaces = distaces
        settingsViewController.provider = provider
        
        settingsViewController.performSelector(onMainThread: #selector(settingsViewController.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewLoads() {
        XCTAssertNotNil(settingsViewController.view, "View not initiated properly")
    }
    
    func testTableViewLoads() {
        XCTAssertNotNil(settingsViewController.tableSettings, "Table not initiated");
    }
    
    func testViewConformsToUITableViewDataSource() {
        XCTAssertTrue(settingsViewController.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testTableViewHasDataSource()
    {
        XCTAssertNotNil(settingsViewController.tableSettings.dataSource, "Table datasource cannot be nil");
    }
    
    func testViewConformsToUITableViewDelegate() {
        XCTAssertTrue(settingsViewController.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(settingsViewController.tableSettings.delegate, "Table datasource cannot be nil");
    }
    
    func testTableViewCellDistanceMetersText() {
        let cell1: SettingCellView = self.settingsViewController.tableView(self.settingsViewController.tableSettings, cellForRowAt: IndexPath(row: 0, section: 0)) as! SettingCellView
        XCTAssertEqual(cell1.labelDistance.text, "100 meters")
    }
    
    func testTableViewCellDistanceKmText() {
        let cell1: SettingCellView = self.settingsViewController.tableView(self.settingsViewController.tableSettings, cellForRowAt: IndexPath(row: 3, section: 0)) as! SettingCellView
        XCTAssertEqual(cell1.labelDistance.text, "1 km")
    
    }
    
}
