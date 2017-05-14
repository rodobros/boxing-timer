//
//  RoundTimer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class RoundTimer : BasicTimer, Observable {
    
    private var info_ : RoundTimerInformation;
    
    // BasicTimer protocol variable
    internal var isFinish_ = false;
    internal var currentTime_ = 0;
    internal var alarmSound_ : SystemSoundID = 0;
    internal var timer_ = Timer();
    
    // Observable protocol variabl
    internal var observers = [Observer]()
    
    private var timeOnSleep_ = Date();
    
    init(view : Observer, info : RoundTimerInformation) {
        if let soundURL = Bundle.main.url(forResource: "DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &alarmSound_);
        }
        info_ = info;
        addObserver(observer: view);
    }
    
    // BasicTimer protocol functions :
    func start() {
        playAlarmSound();
        timer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = info_.secondPerRound;
        // start the timer
        timer_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func end() {
        timer_.invalidate();
        info_.currentRound = 1;
        currentTime_ = 0;
        info_.isBreak = false;
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
    /*
    func setNumberOfRounds(_ value : Int){
        numberOfRounds_ = value;
    }
    
    func setSecondPerRound(_ value : Int){
        secondPerRound_ = value;
    }
    
    func setSecondPerBreak(_ value : Int){
        secondPerBreak_ = value;
    }
     
    
    func getNumberOfRounds() -> Int {
        return info_.numberOfRounds;
    }
    
    func getSecondPerRound() -> Int {
        return secondPerRound_;
    }
    
    func getSecondPerBreak() -> Int {
        return secondPerBreak_;
    }
     */
    func getCurrentRound() -> Int {
        return info_.currentRound;
    }

    
    func isBreak() -> Bool {
        return info_.isBreak;
    }
    
    func isGetReady() -> Bool {
        return info_.isGetReady;
    }
    
    @objc private func timerAction() {
        tryDecrementTimer(1);
    }
    
    private func addTimeToTimer(_ seconds : Int){
        tryDecrementTimer(seconds);
    }
    
    private func tryDecrementTimer(_ secondToRemove : Int) {
        currentTime_ -= secondToRemove;
        if(info_.isBreak)
        {
            if(currentTime_ < 5 && currentTime_ > 0) {
                info_.isGetReady = true;
                vibrate();
            }
            else if(currentTime_ <= 0){
                playAlarmSound();
                currentTime_ = info_.secondPerRound + currentTime_;
                info_.isBreak = false;
                info_.isGetReady = false;
            }
        }
        else
        {
            if(currentTime_ <= 0)
            {
                currentTime_ = info_.secondPerBreak + currentTime_;
                if(info_.currentRound == info_.numberOfRounds)
                {
                    playAlarmSound();
                    isFinish_ = true;
                    end();
                    return;
                }
                else
                {
                    playAlarmSound();
                    info_.isBreak = true;
                    info_.currentRound += 1;
                }
            }
        }
        notify();
    }
}
