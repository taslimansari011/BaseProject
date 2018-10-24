//
//  UIViewControllerExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit
import NotificationBannerSwift

extension UIViewController {
    
    func alert(message: String, bannerType type: BannerType) {
        self.showBanner(message: message, bannerType: type)
    }
    
    func showBanner(message: String, bannerType type: BannerType ) {
        
        DispatchQueue.main.async {
            
            if let bannerView = UINib(nibName: "BannerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? BannerView {
                
                /*  switch type {
                 case BannerType.success:
                 bannerView.imgVW.image =  #imageLiteral(resourceName: "Ic-Banner-tick")
                 case BannerType.info:
                 bannerView.imgVW.image = #imageLiteral(resourceName: "Ic-Banner-Info")
                 case BannerType.warning:
                 bannerView.imgVW.image = #imageLiteral(resourceName: "Ic-Banner-Info")
                 case BannerType.fail:
                 bannerView.imgVW.image = #imageLiteral(resourceName: "Ic-Banner-cross")
                 case .message:
                 bannerView.imgVW.image = #imageLiteral(resourceName: "Ic-banner-message")
                 }*/
                bannerView.lblTitle.text = message
                
                bannerView.addBottomShadow()
                let banner = NotificationBanner(customView: bannerView)
                banner.duration = 2.0
                banner.dismissOnSwipeUp = true
                
                //Set banner height according to text height
                
                var height = message.heightForView(font: UIFont(name: FontName.regular, size: 15)!, width: (ScreenSize.width - 64))
                if height > 100 {
                    height = 100
                    banner.duration = 7.0
                } else if height < 64 {
                    height = 64
                }
                bannerView.topConst.constant = 0.0
                
                if DeviceType.isiPhoneX {
                    height += 30
                }
                
                bannerView.heightConstraint.constant = height
                banner.bannerHeight = height + 4
                banner.show()
            }
        }
    }
}
