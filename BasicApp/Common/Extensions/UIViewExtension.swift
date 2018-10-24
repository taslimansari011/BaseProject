//
//  UIViewExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension UIView {
    func addBottomShadow(height: Int = 1, radius: CGFloat = 1.0, opacity: Float = 0.3) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}
