//
//  FeedCellViewModel.swift
//  Hubrick
//
//  Created by Marco Maddalena on 07/08/2017.
//  Copyright © 2017 Hubrick. All rights reserved.
//

import UIKit

typealias LoadImageSuccessBlock = (UIImage) -> Void
typealias LoadImageFailureBlock = () -> Void

class FeedCellViewModel: NSObject {

    private(set) var feed: Feed?
    
    init(feed: Feed?) {
        self.feed = feed
    }
    
    // MARK: public implementation
    
    var usernameText: String {
        guard let username = self.feed?.user?.username, username != ""  else { return "------"}
        return username
    }
    
    var imgAvatarURL: URL? {
        guard let url = self.feed?.user?.profilePictureUrl, url != ""  else { return nil }
        return URL(string: url)
    }
    
    var imgFeedURL: URL? {
        guard let url = self.feed?.imageUrl, url != ""  else { return nil }
        return URL(string: url)
    }
    
    var captionText: String {
        guard let caption = self.feed?.caption  else { return "" }
        return caption
    }
    
    func loadImage(at url:URL, success:@escaping LoadImageSuccessBlock,failure:@escaping  LoadImageFailureBlock) {
        
        DispatchQueue.global().async {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let request = URLRequest(url: url)
            let cachedResponse = URLCache.shared.cachedResponse(for: request)
            
            if let data = cachedResponse?.data {
                if let downloadedImage = UIImage(data: data) {
                    success(downloadedImage)
                }else{
                    failure()
                }
            } else {
                
                session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error == nil, data != nil {
                        if let downloadedImage = UIImage(data: data!) {
                            success(downloadedImage)
                        }
                    }else{
                        failure()
                    }
                }).resume()
            }
        }
    }
    
}
