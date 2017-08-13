//
//  FeedsViewModel.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

protocol FeedsViewModelDelegate:NSObjectProtocol {
    func feedViewModelDidFindsFeeds(viewModel:FeedsViewModel)
    func feedViewModelDidFindsNoFeeds(viewModel:FeedsViewModel)
    func feedViewModelDidDainedLocation(viewModel:FeedsViewModel)
    func feedViewModelDidFailedLocation(viewModel:FeedsViewModel)
}

class FeedsViewModel: NSObject, LocationProviderDelegate {
    
    weak var delegate: FeedsViewModelDelegate?
    var feeds: [Feed] = []
    private let isolationQueque = DispatchQueue( label: "isolationQueque", attributes: .concurrent)
    var locationProvider: LocationProvider?
    var searchDistanceIndex = SettingsProvider.sharedInstance.currentDistanceIndex
    
    override init() {
        super.init()
    }
    
    var feedsCount: Int {
        var count = 0
        isolationQueque.sync {
            count = self.feeds.count
        }
        return count
    }
    
    var isEmpty: Bool {
        return self.feedsCount == 0
    }
    
    //MARK: public implementation
    
    func startGetFeeds() {
        isolationQueque.sync {
            self.feeds = []
        }
        self.locationProvider = LocationProvider(delegate: self)
    }
    
    func feed(at index: Int) -> Feed? {
        var feed: Feed? = nil
        isolationQueque.sync {
            if index < self.feeds.count {
                feed = self.feeds[index]
            }
        }
        return feed
    }
    
    //MARK: privete implementation
    
    private func getFeedsWith(latitude: String, longitude: String, distance: String, searchDistanceIndex: Int) {
        
        isolationQueque.async(flags: .barrier) {
            let provider = ApiProvider(service: NetworkService.getFeeds(latitude: latitude, longitude: longitude, distance: distance))
            provider.start(completionHandler: { (object, response) in
                
                self.feeds = DataParser.parserGetFeeds(dataToParse: object as? [String:AnyObject])
                if self.isEmpty {
                    self.searchDistanceIndex = searchDistanceIndex + 1
                    if self.isCurrentSearchIndexValid(), let searchDistance = SettingsProvider.sharedInstance.distance(at: self.searchDistanceIndex){
                        self.getFeedsWith(latitude: latitude, longitude: longitude, distance: searchDistance, searchDistanceIndex: self.searchDistanceIndex)
                    } else {
                        self.searchDistanceIndex = SettingsProvider.sharedInstance.currentDistanceIndex
                        self.delegate?.feedViewModelDidFindsNoFeeds(viewModel: self)
                    }
                }else {
                    self.searchDistanceIndex = SettingsProvider.sharedInstance.currentDistanceIndex
                    self.delegate?.feedViewModelDidFindsFeeds(viewModel: self)
                }
            })
        }
    }
    
    private func isCurrentSearchIndexValid() -> Bool {
        return self.searchDistanceIndex < SettingsProvider.sharedInstance.distaces.count
    }
    
    //MARK: LocationProviderDelegate call back
    
    func locationProvider(provider:LocationProvider, didUpdateLatidude latitude:String, longitude:String) {
        let distance = SettingsProvider.sharedInstance.selectedDistace
        let searchDistanceIndex = SettingsProvider.sharedInstance.currentDistanceIndex
        self.getFeedsWith(latitude: latitude, longitude: longitude, distance: distance, searchDistanceIndex: searchDistanceIndex)
    }
    
    func locationProviderDidDainedAuthorization(provider:LocationProvider) {
        self.delegate?.feedViewModelDidDainedLocation(viewModel: self)
    }
    
    func locationProvider(provider:LocationProvider, didFailWithError error: Error) {
        self.delegate?.feedViewModelDidFailedLocation(viewModel: self)
    }
    
}
