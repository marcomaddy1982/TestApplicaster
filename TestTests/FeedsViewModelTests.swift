//
//  FeedsViewModelTests.swift
//  Test
//
//  Created by Marco Maddalena on 13/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import Test
@testable import Alamofire

class FeedsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsyncGetConcurrency() {
        let networkService = NetworkService.getFeeds(latitude: "37.785834", longitude: "-122.406417", distance: "100")
        let provider = ApiProvider(service: networkService)
        let expectationRequest = expectation(description: "Feeds List")
        
        provider.start { (object, response) in
            
            if (response as? DataResponse<Any>) != nil, let responseURL = response.request?.url {
            
                XCTAssertEqual(responseURL.absoluteString, networkService.url, "HTTP response URL should be equal to original URL")
                XCTAssertTrue(response.result.isSuccess)
            }else{
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectationRequest.fulfill()
            
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
