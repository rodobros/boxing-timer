//
//  localMemoryManager.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-08.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation

class LocalMemoryManager {
    fileprivate var userLocalData_: UserDefaults;
    
    init() {
        userLocalData_ = UserDefaults.standard
    }
    
    func getValueForKey(_ key:String) -> String {
        if let value = userLocalData_.string(forKey: key) {
            return value;
        } else {
            return "";
        }
    }
    
    func setValueForKey(_ key:String, value:String) {
        userLocalData_.setValue(value, forKey: key);
        userLocalData_.synchronize();
    }
}
