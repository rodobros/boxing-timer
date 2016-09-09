//
//  roundTimerManager.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class roundTimerManager {
    
    private var numberOfRounds_ = 3;
    private var secondPerRound_ = 180;
    private var secondPerBreak_ = 60;
    private var secondPerGetReady_ = 5;
    private var currentTime_ = 0;
    private var currentRound_ = 1;
    private var isBreak_ = false;
    private var isGetReady_ = false;
    private var isFinish_ = false;
    private var dingdingSound_ : SystemSoundID = 0;
    
    init() {
        if let soundURL = NSBundle.mainBundle().URLForResource("DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL, &dingdingSound_);
        }
    }
    
    
    
    var roundTimer_ = NSTimer();
    
    func setNumberOfRounds(value : Int){
        numberOfRounds_ = value;
    }
    
    func setSecondPerRound(value : Int){
        secondPerRound_ = value;
    }
    
    func setSecondPerBreak(value : Int){
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
    
    func setFinished(value:Bool) {
        isFinish_ = false;
    }
    
    func playBell() {
        AudioServicesPlaySystemSound(dingdingSound_);
        vibrateAlert();
    }
    
    func vibrateAlert() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
    }
    
    func startRounds() {
        playBell();
        roundTimer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = secondPerRound_;
        // start the timer
        roundTimer_ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(roundTimerAction), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        roundTimer_.invalidate();
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
    
    @objc func roundTimerAction() {
        currentTime_ -= 1;
        if(isBreak_)
        {
            if(currentTime_ < 5 && currentTime_ > 0) {
                isGetReady_ = true;
                vibrateAlert();
            }
            else if(currentTime_ == 0){
                playBell();
                currentTime_ = secondPerRound_;
                isBreak_ = false;
                isGetReady_ = false;
            }
        }
        else
        {
            if(currentTime_ == 0)
            {
                currentTime_ = secondPerBreak_;
                if(currentRound_ == numberOfRounds_)
                {
                    playBell();
                    isFinish_ = true;
                    endTimer();
                    return;
                }
                else
                {
                    playBell();
                    isBreak_ = true;
                    currentRound_ += 1;
                }
            }
        }
    }
    
    func getCurrentRoundMinutes() -> String {
       return Int(floor(Double(currentTime_) / 60.0)).description;
    }
    
    func getCurrentRoundSeconds() -> String {
        let seconds = Int(Double(currentTime_) % 60.0);
        if(seconds < 10){
            return "0" + seconds.description;
        }
        return seconds.description;
    }
}