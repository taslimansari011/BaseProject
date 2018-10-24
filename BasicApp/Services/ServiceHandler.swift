//
//  ServiceHandler.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit
import Alamofire

class ServiceHandler: NSObject {
    
    static var sessionManager: SessionManager? = sessionManagerWithHeaders()
    
    static func sessionManagerWithHeaders() -> SessionManager {
        
        var defaultHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        //Get Access token from user defaults
        if let accessToken = userDefaults.value(forKey: "accessToken"), !(accessToken as AnyObject).isEmpty {
            defaultHeaders["Authorization"] = "token \(accessToken)"
        }
        
        log.debug("=> Default headers are:\n\(defaultHeaders)")
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    static func setApiAuthorization(withAccessToken accessToken: String) {
        
        let defaultHeaders: HTTPHeaders = [
            "Authorization": "token \(accessToken)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        log.debug("=> Default headers are:\n\(defaultHeaders)")
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // Cancel All Active Request
    static func cancelAllRunningRequest(completion: @escaping (_ finished: Bool) -> Void) {
        sessionManager?.session.getTasksWithCompletionHandler { dataTasks, _, _ in
            
            for index in 0..<dataTasks.count {
                dataTasks[index].cancel()
            }
            completion(true)
        }
    }
    
    static func request (
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Any? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        withLoader loader: Bool = false,
        loaderTransparency transparentLoader: Bool = false,
        andCompletionHandler completion: @escaping (DataResponse<Any>) -> Void) {
        
        //Check if internet connection is available
        if CommonClass.isInternetAvailable() {
            
            if sessionManager == nil {
                sessionManager = sessionManagerWithHeaders()
            }
            
            //Service request Url
            let completeUrl = (ServiceUrl.baseUrl+url).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            var dataRequest: DataRequest?
            //set parameters
            if parameters == nil || parameters is Parameters {
                let params = parameters as? Parameters
                dataRequest = sessionManager!.request (
                    completeUrl!,
                    method: method,
                    parameters: params,
                    encoding: encoding,
                    headers: headers
                )
            } else {
                if let url = URL(string: (ServiceUrl.baseUrl+url)) {
                var request = URLRequest(url: url)
                request.httpMethod = method.rawValue
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!)
                dataRequest = sessionManager!.request(request)
                }
            }
            
            dataRequest!.validate().responseJSON { (response) in
                
                completion(response)
                
                log.debug("Request URL: \(String(describing: ServiceUrl.baseUrl+url))")   // original url request
                log.debug("Request Body: \(String(describing: parameters))")   // original url request
                log.debug("Response: \(String(describing: response.response))") // http url response
                log.debug("Result: \(response.result)")                         // response serialization result
                log.debug("Response JSON:\n\(response.result.value ?? "")") // serialized json response
                
                switch response.result {
                case .failure(let error as NSError):
                    
                    let viewController = CommonClass.appRootController
      
                    log.error("\(error.debugDescription)")
                    if error.domain == NSURLErrorDomain && (error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost) {
                        viewController?.alert(message: AlertMessage.internetConnectionError, bannerType: .fail)
                    } else if error.domain == NSURLErrorDomain && (error.code == NSURLErrorCannotConnectToHost || error.code == NSURLErrorCannotFindHost) {
                        viewController?.alert(message: "Server not accessible.", bannerType: .fail)
                    } else if response.response?.statusCode == 401 {
                        //Logout user
                        viewController?.alert(message: "Your session is expired.\nPlease login again.", bannerType: .fail)
                    } else {
                        if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8) {
                            
                            log.error("Failure Response JSON: \(json)")
                            
                            do {
                                let dictErrorJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                                // handle  error here
                                log.error("Failure Response JSON: \(String(describing: dictErrorJson))")
                            
                            } catch _ {
                                if error.localizedDescription != "cancelled" {
                                    //Request is cancelled
                                    viewController?.alert(message: error.localizedDescription, bannerType: .fail)
                                }
                            }
                        } else {
                            if error.localizedDescription != "cancelled" {
                                viewController?.alert(message: error.localizedDescription, bannerType: .fail)
                            }
                        }
                    }
                default: break
                }
            }
        } else {
            let error = NSError(domain: "", code: 503, userInfo: nil)
            completion(DataResponse(request: nil, response: nil, data: nil, result: .failure(error)))
        }
        
    }
    
    static func upload (
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        to url: URLConvertible,
        method: HTTPMethod = .put,
        headers: HTTPHeaders? = nil,
        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        if CommonClass.isInternetAvailable() {
            do {
                let urlRequest = try URLRequest(url: url, method: method, headers: headers)
                
                return upload (
                    multipartFormData: multipartFormData,
                    usingThreshold: encodingMemoryThreshold,
                    with: urlRequest,
                    encodingCompletion: encodingCompletion
                )
            } catch {
                DispatchQueue.main.async { encodingCompletion?(.failure(error)) }
            }
        } else {
            let error = NSError(domain: "", code: 503, userInfo: nil)
            DispatchQueue.main.async { encodingCompletion?(.failure(error)) }
        }
    }
    
    static func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        with urlRequest: URLRequestConvertible,
        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        if sessionManager == nil {
            sessionManager = sessionManagerWithHeaders()
        }
        return sessionManager!.upload(
            multipartFormData: multipartFormData,
            usingThreshold: encodingMemoryThreshold,
            with: urlRequest,
            encodingCompletion: encodingCompletion
        )
    }
}
