//
//  UICollectionViewExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    //set view for empty data in collection view
    func setNoDataViewWithImage(image: UIImage? = nil, message: String? = nil ) {
        
        self.removeNoDataView()
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        if let msg = message {
            noDataLabel.text = msg
        } else {
            noDataLabel.text = "No Data Available"
        }
        
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        
        let detailImgV = UIImageView()
        if let img = image {
            detailImgV.image = img
        } else {
            //Set default image here
            //detailImgV.image = UIImage(named: "ic-data")
        }
        
        detailImgV.contentMode = .scaleToFill
        detailImgV.widthAnchor.constraint(equalToConstant: 120).isActive = true
        detailImgV.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let verticalSV = UIStackView()
        verticalSV.axis = .vertical
        verticalSV.spacing = 0
        verticalSV.alignment = .center
        verticalSV.distribution = .equalSpacing
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        verticalSV.addArrangedSubview(detailImgV)
        verticalSV.addArrangedSubview(noDataLabel)
        
        self.addSubview(verticalSV)
        //        verticalSV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        verticalSV.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: -20.0).isActive = true
        verticalSV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        verticalSV.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        verticalSV.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func removeNoDataView() {
        
        if self.backgroundView?.viewWithTag(999) != nil {
            self.backgroundView = nil
        }
    }
    
    func removeNoDataViewStackView() {
        for view in self.subviews where view is UIStackView {
            //if view is UIStackView {
            view.removeFromSuperview()
            //}
        }
    }
}
