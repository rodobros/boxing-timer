//
//  FirstViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class RoundTimerViewController: UIViewController {
    
    // timer outlets
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var roundInformationLabel: UILabel!
    
    @IBOutlet weak var minutesTimerLabel: UILabel!
    @IBOutlet weak var separatorTimerLabel: UILabel!
    @IBOutlet weak var secondsTimerLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    //timer variables
    var passedRoundTimer_ = RoundTimer();
    private var viewUpdateTimer = Timer();
    
    // User Data memory
    private var localMemoryManager_ = LocalMemoryManager();
    
    private var timeOnSleep_ = Date();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
        startRounds();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRounds() {
        UIApplication.shared.isIdleTimerDisabled = true; // prevent iphone from going to sleep
        passedRoundTimer_.start();
    }
    
    @IBAction func interruptRounds(sender: AnyObject) {
        // pause timer here
    }
    
    @IBAction func stopButtonClick(_ sender: Any) {
        endAndCleanup()
    }
    
    private func endAndCleanup(){
        UIApplication.shared.isIdleTimerDisabled = false; // allow iphone to sleep
        passedRoundTimer_.end();
    }
    
    private func goBackToSetup(){
        performSegue(withIdentifier: "roundToSetupSegue", sender: self);
    }
    
    private func yellowBackground() {
        /*
         for var i in self.view.subviews {
         if(i.tag > 0 && i.tag < 4) {
         i.backgroundColor = UIColor.yellowColor();
         }
         }
         */
    }
    
    private func whiteBackground() {
        /*
         for var i in self.view.subviews {
         if(i.tag > 0 && i.tag < 4) {
         i.backgroundColor = UIColor.whiteColor();
         }
         }
         */
    }
    
   @objc private func update() {
        minutesTimerLabel.text = passedRoundTimer_.getCurrentMinutes();
        secondsTimerLabel.text = passedRoundTimer_.getCurrentSeconds();
        if(passedRoundTimer_.isBreak()){
            if(passedRoundTimer_.isGetReady()){
                roundInformationLabel.text = "Get ready!";
                yellowBackground()
            } else {
                whiteBackground()
                roundInformationLabel.text = "Break";
            }
        } else {
            whiteBackground()
            roundInformationLabel.text = "Round " + passedRoundTimer_.getCurrentRound().description;
        }
        if(passedRoundTimer_.isFinished()){
            endAndCleanup();
            goBackToSetup();
        }
    }
    
    // handles app going to background :
    private func willResignActive(_ notification: Notification) {
        // code to execute when app goes to background
        timeOnSleep_ = Date();
    }
    
    // handles app going to foreground :
    private func willEnterForeground(_ notification: Notification) {
        // code to execute when app is back from backgorund
        let timeNow = Date();
        let timeDifference = timeNow.timeIntervalSince(timeOnSleep_); // this is the value in seconds
        passedRoundTimer_.addTimeToTimer((Int(timeDifference)));
    }
}

