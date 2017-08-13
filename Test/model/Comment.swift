//
//  Comment.swift
//  Test
//
//  Created by Marco Maddalena on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: NSObject {

    var identifier:String!
    var text:String? = ""
    var creationDate:String? = ""
    var username:String? = ""
    var avatarUrl:String? = ""
    
    init?(jsonData json: JSON) {
    
        self.identifier = json[Constant.kParserId].stringValue
        self.creationDate = json[Constant.kParserCreatedTime].stringValue
        self.text = json[Constant.kParserText].stringValue
        
        if let from: [String:JSON] = json[Constant.kParserFrom].dictionary {
            let fromJSON:JSON = JSON(from)
            
            self.username = fromJSON[Constant.kParserUsername].string
            self.avatarUrl = fromJSON[Constant.kParserProfilePicture].string
        }
    }
}
