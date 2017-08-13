//
//  Feed.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    var username:String? = ""
    var profilePictureUrl:String? = ""
}

class Feed: NSObject {

    var identifier:String!
    var user: User? = User()
    var imageUrl:String? = ""
    var caption:String? = ""
//    var commentAmount:Int? = 0
//    var comments:[Comment]? = []
    
    override init() {
        
    }
    
    init?(jsonData json: JSON) {
        
        self.identifier = json[Constant.kParserId].stringValue
        self.caption = json[Constant.kParserCaption].stringValue
        
        if let user: [String:JSON] = json[Constant.kParserUser].dictionary {
            let userJSON:JSON = JSON(user)
            
            self.user?.username = userJSON[Constant.kParserUsername].string
            self.user?.profilePictureUrl = userJSON[Constant.kParserProfilePicture].string
        }
        
        if let images: [String:JSON] = json[Constant.kParserImages].dictionary {
            let imagesJSON:JSON = JSON(images)
            
            if let resolution: [String:JSON] = imagesJSON[Constant.kParserStandardResolution].dictionary {
                let resolutionJSON:JSON = JSON(resolution)
                self.imageUrl = resolutionJSON[Constant.kParserStandardResolutionUrl].string
            }
        }
        
        /*
        if let comments: [String:JSON] = json[Constant.kParserComments].dictionary {
            let commentsJSON:JSON = JSON(comments)
            self.commentAmount = commentsJSON[Constant.kParserCount].intValue
        }
        */
    }
}
