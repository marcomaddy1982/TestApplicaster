//
//  NetworkService.swift
//  Test
//
//  Created by Marco Maddalena on 26/07/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import Alamofire

let baseUrlString = "https://api.instagram.com/v1/"
let apiAccessToken = "2722339916.28724d0.055ee8a969374d1ca1823e6f2a3bc3ab"

enum NetworkService {

    case getFeeds(latitude: String, longitude: String, distance: String)
    case getComments(feedId: String)
    
    var url: String {
        switch self {
        case .getFeeds(let lat, let lng, let distance):
            return baseUrlString + "media/search?lat=" + lat + "&lng=" + lng + "&distance=" + distance + "&access_token=" + apiAccessToken
        case .getComments(let feedId):
            return baseUrlString + "media/" + feedId + "/comments?" + apiAccessToken
        }
    }
    
    var parameters: [String: AnyObject]?{
        switch self {
        case .getFeeds,
             .getComments:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeeds,
             .getComments:
            return .get
        }
    }
    var encoding: ParameterEncoding {
        switch self {
        case .getFeeds,
             .getComments:
            return JSONEncoding.default
        }
    }
    
    var headers: [String: String]
    {
        switch self {
        case .getFeeds,
             .getComments:
            return ["Content-Type": "application/json",
                    "Accept" : "application/json"]
        }
    }
}
