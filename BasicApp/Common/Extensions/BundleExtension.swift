//
//  BundleExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var bundleId: String {
        return bundleIdentifier ?? ""
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
}
