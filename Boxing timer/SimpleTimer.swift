//
//  simpleTimer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class SimpleTimer : BasicTimer {
    
    fileprivate var totalDuration_ = 180;
    
    // variables from BasicTimer protocol
    internal var currentTime_ = 0;
    internal var isFinish_ = false;
    internal var alarmSound_ : SystemSoundID = 0;
    internal var timer_ = Timer();
    
    init() {
        if let soundURL = Bundle.main.url(forResource: "DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &alarmSound_);
        }
    }
    
    
    
    func setTotalDuration(_ value : Int){
        totalDuration_ = value;
    }
    
    func getTotalDuration() -> Int {
        return totalDuration_;
    }
    
    func isFinished() -> Bool {
        return isFinish_;
    }
    
    func setFinished(_ value:Bool) {
        isFinish_ = value;
    }
    
    func start() {
        playAlarmSound();
        timer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = totalDuration_;
        // start the timer
        timer_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(simpleTimerAction), userInfo: nil, repeats: true)
    }
    
    func end() {
        timer_.invalidate();
        currentTime_ = 0;
    }

    
    @objc private func simpleTimerAction() {
        tryDecrementTimer(1);
    }
    
    func addTimeToTimer(_ seconds : Int){
        tryDecrementTimer(seconds);
    }
    
    private func tryDecrementTimer(_ secondsToDecrement : Int){
        currentTime_ -= secondsToDecrement;
        if(currentTime_ <= 0)
        {
            playAlarmSound();
            isFinish_ = true;
            end();
        }
    }
}
