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
    var roundTimerInformation = roundTimerManager();
    var viewUpdateTimer = Timer();
    
    // User Data memory
    var localMemoryManager_ = LocalMemoryManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func StartRounds() {
        UIApplication.shared.isIdleTimerDisabled = true; // prevent iphone from going to sleep
        roundTimerInformation.startRounds();
    }
    
    @IBAction func interruptRounds(sender: AnyObject) {
        // pause timer here
    }
    
    @IBAction func stopRounds(_ sender: Any) {
        UIApplication.shared.isIdleTimerDisabled = false;
        roundTimerInformation.endTimer();
    }
    
    func yellowBackground() {
        /*
         for var i in self.view.subviews {
         if(i.tag > 0 && i.tag < 4) {
         i.backgroundColor = UIColor.yellowColor();
         }
         }
         */
    }
    
    func whiteBackground() {
        /*
         for var i in self.view.subviews {
         if(i.tag > 0 && i.tag < 4) {
         i.backgroundColor = UIColor.whiteColor();
         }
         }
         */
    }
    
    func update() {
        minutesTimerLabel.text = roundTimerInformation.getCurrentRoundMinutes();
        secondsTimerLabel.text = roundTimerInformation.getCurrentRoundSeconds();
        if(roundTimerInformation.isBreak()){
            if(roundTimerInformation.isGetReady()){
                roundInformationLabel.text = "Get ready!";
                yellowBackground()
            } else {
                whiteBackground()
                roundInformationLabel.text = "Break";
            }
        } else {
            whiteBackground()
            roundInformationLabel.text = "Round " + roundTimerInformation.getCurrentRound().description;
        }
        if(roundTimerInformation.isFinished()){
            UIApplication.shared.isIdleTimerDisabled = false; // allow iphone to sleep
            roundTimerInformation.setFinished(false);
        }
    }
}

