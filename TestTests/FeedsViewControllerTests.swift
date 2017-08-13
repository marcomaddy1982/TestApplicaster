//
//  FeedsViewControllerTests.swift
//  Test
//
//  Created by Marco Maddalena on 13/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test

class FeedsViewControllerTests: XCTestCase {
    
    var feedsViewController: FeedViewController!
    var viewModel = FeedsViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        feedsViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        feedsViewController.performSelector(onMainThread: #selector(feedsViewController.loadView), with: nil, waitUntilDone: true)
        let feed: Feed = Feed()
        feed.identifier = "1"
        feed.imageUrl = "http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg"
        feed.caption = "This is the best basketball player ever"
        feed.user = User()
        feed.user?.username = "Maddy1982"
        feed.user?.profilePictureUrl = "https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png"
        
        viewModel.feeds = [feed]
        feedsViewController.viewModel = viewModel
        
        feedsViewController.performSelector(onMainThread: #selector(feedsViewController.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewLoads() {
        XCTAssertNotNil(feedsViewController.view, "View not initiated properly")
    }
    
    func testTableViewLoads() {
        XCTAssertNotNil(feedsViewController.tableFeed, "Table not initiated");
    }
    
    func testViewConformsToUITableViewDataSource() {
        XCTAssertTrue(feedsViewController.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testTableViewHasDataSource()
    {
        XCTAssertNotNil(feedsViewController.tableFeed.dataSource, "Table datasource cannot be nil");
    }
    
    func testViewConformsToUITableViewDelegate() {
        XCTAssertTrue(feedsViewController.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(feedsViewController.tableFeed.delegate, "Table datasource cannot be nil");
    }
    
    func testTableViewCellLabels() {
        let cell1: FeedCellView = self.feedsViewController.tableView(self.feedsViewController.tableFeed, cellForRowAt: IndexPath(row: 0, section: 0)) as! FeedCellView
        XCTAssertEqual(cell1.labelUsername.text, "Maddy1982")
        XCTAssertEqual(cell1.labelCaption.text, "This is the best basketball player ever")
    }
}
