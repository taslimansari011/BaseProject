//
//  Storyboard.swift
//
//  Created by Finoit Technologies, Inc.
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    
    func get() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
    
    func getViewController<T: UIViewController>() -> T {
        let storyboard = UIStoryboard.init(name: self.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.name) as? T else {
            fatalError("\(T.name) available in \(self.rawValue) storyboard. But it's not the type of \(T.name).")
        }
        return viewController
    }
}
