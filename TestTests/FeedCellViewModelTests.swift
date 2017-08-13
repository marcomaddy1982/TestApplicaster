//
//  FeedCellViewModelTests.swift
//  Test
//
//  Created by Marco Maddalena on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test
@testable import SwiftyJSON

class FeedCellViewModelTests: XCTestCase {
    
    var feed: Feed = Feed()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        feed.identifier = "1"
        feed.imageUrl = "http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg"
        feed.caption = "This is the best basketball player ever"
        feed.user = User()
        feed.user?.username = "Maddy1982"
        feed.user?.profilePictureUrl = "https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: property username
    func testCellViewModelCaptionNil() {
        
        feed.caption = nil
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.captionText, "")
    }
    
    func testCellViewModelCaptionEmpty() {
        
        feed.caption = ""
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.captionText, "")
    }
    
    func testCellViewModelCaptionOK() {
        
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.captionText, "This is the best basketball player ever")
    }
    
    // MARK: property imageUrl
    func testCellViewModelImgFeedURLNil() {
        
        feed.imageUrl = nil
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNil(feedViewModel.imgFeedURL)
    }
    
    func testCellViewModelImgFeedURLEmpty() {
        
        feed.imageUrl = ""
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNil(feedViewModel.imgFeedURL)
    }
    
    func testCellViewModelImgFeedURLOK() {
        
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNotNil(feedViewModel.imgFeedURL)
    }
    
    // MARK: property profilePictureUrl
    func testCellViewModelImgAvatarURLNil() {
        
        feed.user?.profilePictureUrl = nil
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNil(feedViewModel.imgAvatarURL)
    }
    
    func testCellViewModelImgAvatarURLEmpty() {
        
        feed.user?.profilePictureUrl = ""
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNil(feedViewModel.imgAvatarURL)
    }
    
    func testCellViewModelImgAvatarURLOK() {
        
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertNotNil(feedViewModel.imgAvatarURL)
    }
    
    // MARK: property username
    func testCellViewModelUsernameNil() {
        
        feed.user?.username = nil
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.usernameText, "------")
    }
    
    func testCellViewModelUsernameEmpty() {
        
        feed.user?.username = ""
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.usernameText, "------")
    }
    
    func testCellViewModelUsernameOK() {
        
        let feedViewModel = FeedCellViewModel(feed: feed)
        XCTAssertEqual(feedViewModel.usernameText, "Maddy1982")
    }
}
