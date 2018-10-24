//
//  NSObjectExtension.swift
//
//
//  Created by Finoit Technologies, Inc.
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension NSObject {
    var name: String {
        return String(describing: type(of: self))
    }
    
    class var name: String {
        return String(describing: self)
    }
}
