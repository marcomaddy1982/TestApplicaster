//
//  ApiProvider.swift
//  Test
//
//  Created by Marco Maddalena on 26/07/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkServiceAlamofireCompletitionhandler = (AnyObject?, DataResponse<Any>) -> Void

class ApiProvider {
    
    var service: NetworkService
    
    required init(service: NetworkService) {
        self.service = service
    }
    
    func start(completionHandler: @escaping NetworkServiceAlamofireCompletitionhandler) {
        let request = Alamofire.request(self.service.url,
                          method: self.service.method,
                          parameters: self.service.parameters,
                          encoding: self.service.encoding,
                          headers: self.service.headers)
        
        request.responseJSON { (response) in
            completionHandler(response.result.value as AnyObject?, response)
        }
    }
}
