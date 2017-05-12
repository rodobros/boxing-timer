//
//  BasicTimer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-11.
//  Copyright © 2017 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

protocol BasicTimer {
    var isFinish_ : Bool {get set}
    var alarmSound_ : SystemSoundID {get set}
    var timer_ : Timer {get set}
    var currentTime_ : Int {get set}
    
    func end()
    func start()
    func addTimeToTimer(_ seconds : Int)
}

extension BasicTimer {
    
    func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
    }
    
    func playAlarmSound() {
        AudioServicesPlaySystemSound(alarmSound_);
        vibrate();
    }
    
    func isFinished() -> Bool {
        return isFinish_;
    }
    
    mutating func setFinished(_ value:Bool) {
        isFinish_ = value;
    }
    
    func getCurrentMinutes() -> String {
        return Int(floor(Double(currentTime_) / 60.0)).description;
    }
    
    func getCurrentSeconds() -> String {
        let seconds = Int(Double(currentTime_).truncatingRemainder(dividingBy: 60.0));
        if(seconds < 10){
            return "0" + seconds.description;
        }
        return seconds.description;
    }
    
}

