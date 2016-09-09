//
//  localMemoryManager.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-08.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation

class LocalMemoryManager {
    private var userLocalData_: NSUserDefaults;
    
    init() {
        userLocalData_ = NSUserDefaults.standardUserDefaults()
    }
    
    func getValueForKey(key:String) -> String {
        if let value = userLocalData_.stringForKey(key) {
            return value;
        } else {
            return "";
        }
    }
    
    func setValueForKey(key:String, value:String) {
        userLocalData_.setValue(value, forKey: key);
        userLocalData_.synchronize();
    }
}