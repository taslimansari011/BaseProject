//
//  StringExtension.swift
//  
//
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

extension String {
    
    var dateValue: Date? {
        
        guard !self.isEmpty else {
            return nil
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.timeZone = TimeZone(secondsFromGMT: 0)
        
        var date: Date? = dateFormatterGet.date(from: self)
        if date == nil {
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            date = dateFormatterGet.date(from: self)
            if date == nil {
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                date = dateFormatterGet.date(from: self)
                if date == nil {
                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                    date = dateFormatterGet.date(from: self)
                }
            }
        }
        return date
    }
    
    var boolValue: Bool {
        switch self {
        case "TRUE", "True", "true", "YES", "Yes", "yes", "1":
            return true
        default:
            return false
        }
    }
    
    var isEmail: Bool {
        if self.isEmpty {
            return false
        }
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    
    var isContainsCharacter: Bool {
        if self.isStringEmpty {
            return false
        }
        let regex = ".*?[a-zA-Z].*?" as String
        let text = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid  = text.evaluate(with: self) as Bool
        return isValid
    }
    var isStringEmpty: Bool {
        return self.stringByTrimmingWhiteSpace.isEmpty ? true : false
    }
    
    var stringByTrimmingWhiteSpace: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    var timeAgoString: String {
        
        let date = self.dateValue ?? Date()
        let seconds = date.timeIntervalSince1970
        let currentUnixDate =  Date().timeIntervalSince1970
        let timeDifference = currentUnixDate - seconds
        
        if timeDifference >= 0 {
            let hour = timeDifference / 3600
            let min = timeDifference / 60
            let sec = timeDifference
            
            if Int(hour) >= 1 && Int(hour) < 24 {
                return Int(hour) == 1 ? "\(Int(hour)) hour ago" : "\(Int(hour)) hours ago"
            } else if Int(min) >= 1 && Int(min) < 60 {
                return Int(min) == 1 ? "\(Int(min)) min ago" : "\(Int(min)) mins ago"
            } else if sec >= 0 && sec < 60 {
                return "Just Now"
            } else if date.isYesterday {
                return "Yesterday"
            } else {
                return date.getDateString(forFormat: "MMM, dd yyyy")
            }
        } else {
            return "Just Now"
        }
    }
    
    var  isImage: Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        
        if let ext = self.pathExtension?.localizedLowercase {
            return imageFormats.contains(ext)
        }
        
        return false
    }
    
    var pathExtension: String? {
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty {
            return nil
        }
        
        return ext
    }
    
    var isURL: Bool {
        let url = URL(string: self)
        return url != nil && url!.scheme != nil && url!.host != nil
    }
    
    func getSize(fontName: String, size: CGFloat) -> CGSize? {
        
        if let font = UIFont(name: fontName, size: size) {
            let fontAttributes = [NSAttributedStringKey.font: font]
            let myText = self
            return (myText as NSString).size(withAttributes: fontAttributes)
        } else {
            return nil
        }
    }
    
    func getDateString(forFormat format: String) -> String {
        
        guard !self.isEmpty else {
            return ""
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        let date: Date? = dateFormatterGet.date(from: self)
        if date != nil {
            return dateFormatterPrint.string(from: date! as Date)
        } else {
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date: Date? = dateFormatterGet.date(from: self)
            if date != nil {
                return dateFormatterPrint.string(from: date! as Date)
            } else {
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                let date: Date? = dateFormatterGet.date(from: self)
                if date != nil {
                    return dateFormatterPrint.string(from: date! as Date)
                }
            }
            return ""
        }
    }
    
    public func heightForView(font: UIFont, width: CGFloat) -> CGFloat {
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func getStringSize(forWidth width: CGFloat? = nil, andFont font: UIFont? = nil) -> CGSize {
        if let font = font ?? UIFont(name: FontName.regular, size: 12) {
            let fontAttributes = [NSAttributedStringKey.font: font]
            let attributedText = NSAttributedString(string: self, attributes: fontAttributes)
            let rectSize = CGSize(width: CGFloat(width ?? CGFloat.greatestFiniteMagnitude), height: CGFloat(CGFloat.greatestFiniteMagnitude))
            let rect = attributedText.boundingRect(with: rectSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            return rect.size
        }
        return .zero
    }
    
    func safelyLimitedTo(length num: Int) -> String {
        let string = self
        if string.count <= num { return self }
        return String( Array(string).prefix(upTo: num) )
    }
    
}
