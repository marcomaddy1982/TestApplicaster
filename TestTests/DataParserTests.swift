//
//  DataParserTests.swift
//  Test
//
//  Created by Marco Maddalena on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test

class DataParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Parser Function
    func testParserEmpty() {
        
        let response = "{\"data\": []}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 0)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func testParserOK() {
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}},\"id\": \"1\",\"location\": null},{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": null,\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}},\"id\": \"2\",\"location\": null},{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": null,\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}},\"id\": \"3\",\"location\": null}]}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 3)
                
            }catch {
                    print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Parser Feed imageUrl property
    func testParserFeedImageFeedNil(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"Marco\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": null,\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.imageUrl, nil)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func testParserFeedImageFeedEmpty(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.imageUrl, "")
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: Parser Feed caption property
    func testParserFeedCaptionNil(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"Marco\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": null,\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.caption, nil)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func testParserFeedCaptionEmpty(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.caption, "")
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Parser Feed username property
    func testParserFeedUsernameNil(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": null,\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.user?.username, nil)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func testParserFeedUsernameEmpty(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"https://pixabay.com/it/viso-faccia-illustrazione-1778889/\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"http://www.lineadiretta24.it/wp-content/uploads/2014/01/images_IMMAGINI2013_michael-jordan-trofeo-860x450_c.jpg\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.user?.username, "")
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Parser Feed avatarImage property
    func testParserFeedImageAvatarNil(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"Marco\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": null},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": null,\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.user?.profilePictureUrl, nil)
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func testParserFeedImageAvatarEmpty(){
        
        let response = "{\"data\": [{\"type\": \"image\",\"users_in_photo\": [{\"user\": {\"username\": \"\",\"full_name\": \"Kevin S\",\"id\": \"3\",\"profile_picture\": \"\"},\"position\": {\"x\": 0.315,\"y\": 0.9111}}],\"filter\": \"Walden\",\"tags\": [],\"comments\": {\"count\": 2},\"caption\": \"This is the best history basketball player!!!\",\"likes\": {\"count\": 1},\"link\": \"http://instagr.am/p/D/\",\"user\": {\"username\": \"kevin\",\"full_name\": \"Kevin S\",\"profile_picture\": \"https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png\",\"id\": \"3\"},\"created_time\": \"1279340983\",\"images\": {\"low_resolution\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg\",\"width\": 306,\"height\": 306},\"thumbnail\": {\"url\": \"http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg\",\"width\": 150,\"height\": 150},\"standard_resolution\": {\"url\": \"\",\"width\": 612,\"height\": 612}}}"
        
        if let data = response.data(using: .utf8) {
            do {
                let dictFeeds = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let feeds = DataParser.parserGetFeeds(dataToParse: dictFeeds)
                XCTAssertEqual(feeds.count, 1)
                let feed = feeds[0]
                XCTAssertEqual(feed.user?.profilePictureUrl, "")
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
