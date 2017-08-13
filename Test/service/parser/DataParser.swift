//
//  DataParser.swift
//  Test
//
//  Created by Marco Maddalena on 26/07/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataParser {
    
    static func parserGetFeeds(dataToParse: [String:AnyObject]?) -> [Feed]{
    
        /*
        let jsonFeeds = JSON(dataToParse)
        
        if let aFeeds = jsonFeeds[Constant.kParserData].array {
            
            var feeds: [Feed] = []
            
            for feedDict:JSON in aFeeds {
                if let type = feedDict[Constant.kParserType].string, type == Constant.kParserTypeImage{
                    if let feed = Feed(jsonData: feedDict) {
                        feeds.append(feed)
                        if feeds.count == Constant.kFeedMaxAmount {
                            return feeds
                        }
                    }
                }
            }
            
            return feeds
        }
        */
        
        if let path = Bundle.main.path(forResource: "media", ofType: "json")
        {
            do {
                let data = try NSData(contentsOfFile: path, options:NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    let dictFeeds = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String: Any]
                    
                    let jsonFeeds = JSON(dictFeeds)
                    
                    if let aFeeds = jsonFeeds[Constant.kParserData].array {
                        
                        var feeds: [Feed] = []
                        
                        for feedDict:JSON in aFeeds {
                            if let type = feedDict[Constant.kParserType].string, type == Constant.kParserTypeImage{
                                if let feed = Feed(jsonData: feedDict) {
                                    feeds.append(feed)
                                    if feeds.count == Constant.kFeedMaxAmount {
                                        return feeds
                                    }
                                }
                            }
                        }
                        
                        return feeds
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }catch {
                print("Error")
            }
        }
        
        return []
    }
    
    static func parserGetComments(dataToParse: [String:AnyObject]?) -> [Comment] {
        
        let location = "/Users/macbookproretina/Desktop/comments.json"
        let fileContent = try? String(contentsOfFile: location, encoding: String.Encoding.utf8)
        
        if let data = fileContent?.data(using: .utf8) {
            do {
                let dictComments = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let jsonComments = JSON(dictComments)
                
                if let aComments = jsonComments[Constant.kParserData].array {
                    
                    var comments: [Comment] = []
                    for commentDict:JSON in aComments {
                        if let comment = Comment(jsonData: commentDict) {
                            comments.append(comment)
                        }
                    }
                    
                    return comments
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return []
    }
    
}
