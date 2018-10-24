//
//  DemoAPIServices.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.

import UIKit

class DemoAPIServices {
    
    static func serviceDummyRequest(successBlock: @escaping (_ response: AnyObject?) -> Void, failureBlock: @escaping (_ error: Error?) -> Void) {
        
        // url request
        let serviceUrl: String = ""
        
        // parameters
        let parameters: [String: Any] = [:]
        
        // call server
        ServiceHandler.request(serviceUrl, method: .post, parameters: parameters) { (response) in
            switch response.result {
            case .success:
                log.debug("success response: \(response.result.value ?? "")")
            case .failure(let error):
                log.error("\(error)")
            }
        }
    }

}
