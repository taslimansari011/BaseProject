//
//  BannerView.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.

import UIKit

class BannerView: UIView {

    @IBOutlet weak var imgVW: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
