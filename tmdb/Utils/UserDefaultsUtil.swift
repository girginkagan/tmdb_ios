//
//  UserDefaultsUtil.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

public class UserDefaultsUtil{
    
    public func getString(key: String) -> String?{
        return UserDefaults.standard.string(forKey: key)
    }
    
    public func setString(val: String, key: String){
        UserDefaults.standard.setValue(val, forKey: key)
    }
    
    public func getInt(key: String) -> Int?{
        return UserDefaults.standard.integer(forKey: key)
    }
    
    public func setInt(val: Int, key: String){
        UserDefaults.standard.setValue(val, forKey: key)
    }
    
    public func getBool(key: String) -> Bool?{
        return UserDefaults.standard.bool(forKey: key)
    }
    
    public func setBool(val: Bool, key: String){
        UserDefaults.standard.setValue(val, forKey: key)
    }
    
    public func removeData(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
