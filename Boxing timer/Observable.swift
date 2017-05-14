//
//  Observable.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-13.
//  Copyright © 2017 Rodolphe Brossard. All rights reserved.
//

import Foundation
protocol Observable : class {
    var observers : [Observer] {get set}
    
    
}

extension Observable {
    
    func addObserver(observer : Observer)
    {
        observers.append(observer);
    }
    
    func removeObserver(observer : Observer)
    {
        for i in 0...observers.count
        {
            if(observers[i].observerName == observer.observerName)
            {
                observers.remove(at: i);
            }
        }
    }
    
    func removeObserver(name : String)
    {
        for i in 0...observers.count
        {
            if(observers[i].observerName == name)
            {
                observers.remove(at: i);
            }
        }
    }
    
    func notify()
    {
        for obs in observers
        {
            obs.update();
        }
    }
}
