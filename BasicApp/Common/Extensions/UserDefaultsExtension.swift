//
//  UserDefaultsExtension.swift
//
//
//  Created by Finoit Technologies, Inc.
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import Foundation

enum UserDefaultsTypes: String {
    case deleteAfterLogout
    case keepAfterLogout
}
extension UserDefaults {
    
    // Note - Passing nil value will remove the key. You can also create your custom computed properties here instead of calling set/get method.
    static var accessToken: String? {
        set {
            UserDefaults.set(newValue, key: UserDefaultsKeys.accessTokenKey, inUserDefaultType: .deleteAfterLogout)
        }
        get {
            return UserDefaults.get(UserDefaultsKeys.accessTokenKey, inUserDefaultType: .deleteAfterLogout)
        }
        
    }
    
    static func set(_ value: Any?, key: String, inUserDefaultType type: UserDefaultsTypes = .keepAfterLogout) {
        var userDefaultsDictionary: [String: Any] = [String: Any]()
        if let value = userDefaults.object(forKey: type.rawValue) as? [String: Any] {
            userDefaultsDictionary = value
        }
        if let value = value {
            userDefaultsDictionary.updateValue(value, forKey: key)
        } else {
            userDefaultsDictionary.removeValue(forKey: key)
        }
        
        userDefaults.set(userDefaultsDictionary, forKey: type.rawValue)
        userDefaults.synchronize()
    }
    
    static func get<T>(_ key: String, inUserDefaultType type: UserDefaultsTypes = .keepAfterLogout) -> T? {
        var userDefaultsDictionary: [String: Any] = [String: Any]()
        if let value = userDefaults.object(forKey: type.rawValue) as? [String: Any] {
            userDefaultsDictionary = value
        }
        return userDefaultsDictionary[key] as? T
    }
    
    static func clearUserDefaults(forType type: UserDefaultsTypes) {
        userDefaults.removeObject(forKey: type.rawValue)
        userDefaults.synchronize()
    }
}
