//
//  simpleTimer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class SimpleTimer : BasicTimer, Observable {
    
    internal var info_ : SimpleTimerInformation;
    
    // variables from BasicTimer protocol
    internal var currentTime_ = 0;
    internal var isFinish_ = false;
    internal var alarmSound_ : SystemSoundID = 0;
    internal var timer_ = Timer();
    
    // Observable protocol variabl
    internal var observers = [Observer]()
    
    private var timeOnSleep_ = Date();
    
    init(view : Observer, info : SimpleTimerInformation) {
        if let soundURL = Bundle.main.url(forResource: "DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &alarmSound_);
        }
        info_ = info;
        addObserver(observer: view);
    }
    
    func start() {
        playAlarmSound();
        timer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = info_.totalDuration;
        // start the timer
        timer_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(simpleTimerAction), userInfo: nil, repeats: true)
        notify();
    }
    
    func end() {
        timer_.invalidate();
        currentTime_ = 0;
    }

    func notifyAppWillResign() {
        timeOnSleep_ = Date();
    }
    
    func notifyAppWillEnterForeground(){
        // code to execute when app is back from backgorund
        let timeNow = Date();
        let timeDifference = timeNow.timeIntervalSince(timeOnSleep_); // this is the value in seconds
        addTimeToTimer((Int(timeDifference)));
        
    }
    
    @objc private func simpleTimerAction() {
        tryDecrementTimer(1);
    }
    
    private func addTimeToTimer(_ seconds : Int){
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
        notify();
    }
}
