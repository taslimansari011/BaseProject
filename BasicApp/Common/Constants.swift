//
//  Constants.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//
//

import UIKit
import XCGLogger

let log = XCGLogger.default
let appName = "BasicApp"
let appDelegate = UIApplication.shared.delegate as? AppDelegate
let appWindow = UIApplication.shared.keyWindow
let userDefaults = UserDefaults.standard

// MARK: API Keys
struct ServiceUrl {
    
    #if DEV
    static let baseUrl = "http://dev.basicapp.com/"
    #elseif QA
    static let baseUrl = "http://qa.basicapp.com/"
    #else
    static let baseUrl = "http://basicapp.com/"
    #endif
    
}
// MARK: API Keys
struct APIKeys {
  
}

// MARK: DeviceType
struct ScreenSize {
    static let width         = UIScreen.main.bounds.size.width
    static let height        = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

// MARK: DeviceType
struct DeviceType {
    static let isiPhone4OrLess  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone67        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone6P7P      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhoneX      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPad              = UIDevice.current.userInterfaceIdiom == .pad
    static let isiPadPro          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366.0
}

// MARK: Font
struct FontName {
    static let regular         = "HelveticaNeue"
    static let bold        = "HelveticaNeue-bold"
}

// MARK: DateFormat
struct DateFormat {
    static let date = "MMM dd, YYYY"
    static let dateTime = "MMM dd YYYY, hh:mm a"
    static let time12Hour = "hh:mm a"
}

// MARK: Alert Messages
struct AlertMessage {
    
    static let internetConnectionError = "Internet connection not available.\nPlease check it that you are connected to internet and try again."
    static let enterEmail = "Please enter email."
    static let enterValidEmail = "Please enter a valid email."
    static let enterPassword = "Please Enter Password."
    static let passwordLength = "Password must be atleast 8 digits long."
    static let passwordShouldHave = "Password must contain atleast one character."
    static let confirmPassword = "Please confirm your password."
    static let passwordDoNotMatch = "Passwords don't match."
    
}

// MARK: UserDefaultKeys
struct UserDefaultsKeys {
    static let accessTokenKey = "authTkn"
}
