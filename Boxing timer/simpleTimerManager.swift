//
//  simpleTimerManager.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import Foundation
import AudioToolbox

class simpleTimerManager {
    
    private var totalDuration_ = 180;
    private var currentTime_ = 0;
    private var isFinish_ = false;
    private var dingdingSound_ : SystemSoundID = 0;
    
    init() {
        if let soundURL = NSBundle.mainBundle().URLForResource("DingDing", withExtension: "mp3") {
            AudioServicesCreateSystemSoundID(soundURL, &dingdingSound_);
        }
    }
    
    var simpleTimer_ = NSTimer();
    
    func setTotalDuration(value : Int){
        totalDuration_ = value;
    }
    
    func getTotalDuration() -> Int {
        return totalDuration_;
    }
    
    func isFinished() -> Bool {
        return isFinish_;
    }
    
    func setFinished(value:Bool) {
        isFinish_ = value;
    }
    
    func playBell() {
        AudioServicesPlaySystemSound(dingdingSound_);
        vibrateAlert();
    }
    
    func vibrateAlert() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
    }
    
    func start() {
        playBell();
        simpleTimer_.invalidate() // just in case this button is tapped multiple times
        isFinish_ = false;
        currentTime_ = totalDuration_;
        // start the timer
        simpleTimer_ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(simpleTimerAction), userInfo: nil, repeats: true)
    }
    
    func end() {
        simpleTimer_.invalidate();
        currentTime_ = 0;
    }

    
    @objc func simpleTimerAction() {
        currentTime_ -= 1;
        if(currentTime_ == 0)
        {
            playBell();
            isFinish_ = true;
            end();
        }
    }
    
    func getCurrentMinutes() -> String {
        return Int(floor(Double(currentTime_) / 60.0)).description;
    }
    
    func getCurrentSeconds() -> String {
        let seconds = Int(Double(currentTime_) % 60.0);
        if(seconds < 10){
            return "0" + seconds.description;
        }
        return seconds.description;
    }
}