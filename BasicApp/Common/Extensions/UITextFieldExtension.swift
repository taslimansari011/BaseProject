//
//  UITextFieldExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return 160 // (global default-limit. or just, Int.max)
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedTo(length: maxLength)
    }
    
    // Activity indicator in textfield while autosearch is in progress
    func showLoader() {
        
        let viewHeight = self.frame.height - 5
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: viewHeight, height: viewHeight)
        activityIndicator.startAnimating()
        
        if let rightSubview = self.rightView, rightSubview.subviews.isEmpty == false {
            if let rightStackView = self.rightView as? UIStackView {
                rightStackView.frame = CGRect(x: 0, y: 0, width: rightSubview.frame.width + self.frame.height, height: self.frame.height)
                rightStackView.insertArrangedSubview(activityIndicator, at: 0)
                self.rightView = rightStackView
            }
        } else {
            self.rightViewMode = .always
            self.rightView = activityIndicator
            
        }
    }
    
    func hideLoader() {
        
        // rightview has more elements with activity indiator
        if let rightSubview = self.rightView, rightSubview.subviews.count > 1 {
            if let rightStackView = self.rightView as? UIStackView {
                rightStackView.frame = CGRect(x: 0, y: 0, width: rightSubview.frame.width - self.frame.height, height: self.frame.height)
                for subview in rightStackView.arrangedSubviews where subview is UIActivityIndicatorView {
                    //  if subview is UIActivityIndicatorView {
                    rightStackView.removeArrangedSubview(subview)
                    rightStackView.isHidden = true
                    //  }
                }
                self.rightView = rightStackView
            }
        } else {
            self.rightViewMode = .never
            self.rightView = nil
        }
    }
}
