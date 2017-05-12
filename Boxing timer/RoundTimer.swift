//
//  RoundTimer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class RoundTimer : BasicTimer {
    
    fileprivate var numberOfRounds_ = 3;
    fileprivate var secondPerRound_ = 180;
    fileprivate var secondPerBreak_ = 60;
    fileprivate var secondPerGetReady_ = 5;
    fileprivate var currentRound_ = 1;
    fileprivate var isBreak_ = false;
    fileprivate var isGetReady_ = false;
    
    // variables from BasicTimer protocol
    internal var isFinish_ = false;
    internal var currentTime_ = 0;
    internal var alarmSound_ : SystemSoundID = 0;
    internal var timer_ = Timer();
    
    init() {
        if let soundURL = Bundle.main.url(forResource: "DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &alarmSound_);
        }
    }
    
    func start() {
        playAlarmSound();
        timer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = secondPerRound_;
        // start the timer
        timer_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
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
        return numberOfRounds_;
    }
    
    func getSecondPerRound() -> Int {
        return secondPerRound_;
    }
    
    func getSecondPerBreak() -> Int {
        return secondPerBreak_;
    }
    
    func getCurrentRound() -> Int {
        return currentRound_;
    }
    
    func isFinished() -> Bool {
        return isFinish_;
    }
    
    func setFinished(_ value:Bool) {
        isFinish_ = false;
    }
    
    func end() {
        timer_.invalidate();
        currentRound_ = 1;
        currentTime_ = 0;
        isBreak_ = false;
    }
    
    func isBreak() -> Bool {
        return isBreak_;
    }
    
    func isGetReady() -> Bool {
        return isGetReady_;
    }
    
    @objc private func timerAction() {
        tryDecrementTimer(1);
    }
    
    func addTimeToTimer(_ seconds : Int){
        tryDecrementTimer(seconds);
    }
    
    private func tryDecrementTimer(_ secondToRemove : Int) {
        currentTime_ -= secondToRemove;
        if(isBreak_)
        {
            if(currentTime_ < 5 && currentTime_ > 0) {
                isGetReady_ = true;
                vibrate();
            }
            else if(currentTime_ <= 0){
                playAlarmSound();
                currentTime_ = secondPerRound_ + currentTime_;
                isBreak_ = false;
                isGetReady_ = false;
            }
        }
        else
        {
            if(currentTime_ <= 0)
            {
                currentTime_ = secondPerBreak_ + currentTime_;
                if(currentRound_ == numberOfRounds_)
                {
                    playAlarmSound();
                    isFinish_ = true;
                    end();
                    return;
                }
                else
                {
                    playAlarmSound();
                    isBreak_ = true;
                    currentRound_ += 1;
                }
            }
        }
    }
}
