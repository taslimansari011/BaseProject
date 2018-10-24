//
//  CommonClass.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//
//

import Foundation
import SystemConfiguration
import UIKit

class CommonClass: NSObject {
    
    class var appRootController: UIViewController? {

        var rootViewController = UIApplication.shared.keyWindow?.rootViewController

            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.viewControllers.first
            } else if let tabBarController = rootViewController as? UITabBarController {
                rootViewController = tabBarController.selectedViewController
            } else if let splitViewController = rootViewController as? UISplitViewController {
                rootViewController = splitViewController.viewControllers.count > 1 ? splitViewController.viewControllers[1] : nil
            }
            
            if let presentedViewController = rootViewController?.presentedViewController {
                rootViewController = presentedViewController
            }
            
            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.topViewController
            }
            
            return rootViewController
    }
    
    static func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var isInternet = false
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return isInternet
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        isInternet = (isReachable && !needsConnection)
        if !isInternet {
            let viewController = CommonClass.appRootController
            viewController?.alert(message: AlertMessage.internetConnectionError, bannerType: .fail)
        }
        
        return isInternet
    }
    
    static func isInternetReachableToGoogle(completionHandler:@escaping (Bool) -> Void) {
        if isInternetAvailable() {
            DispatchQueue.main.async {
                
                let url = URL(string: "https://www.google.com")!
                do {
                    _ = try Data(contentsOf: url as URL)
                    completionHandler(true)
                    
                } catch {
                    print("Unable to load data")
                    // do something here...
                    print("Internet Connection not Available!")
                    let viewCont = CommonClass.appRootController
                    viewCont?.alert(message: AlertMessage.internetConnectionError, bannerType: .fail)
                    completionHandler(false)
                }
                
            }
        }
    }
   
}
