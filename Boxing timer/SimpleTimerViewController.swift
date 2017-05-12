//
//  SimpleTimerViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-09.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class SimpleTimerViewController: UIViewController {
    
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerTitle: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var timerSeparator: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var passedSimpleTimer_ = SimpleTimer(); // timer that will received from setup viewController
    
    var viewUpdateTimer = Timer(); // timer used to update the view
    
    private var timeOnSleep_ = Date();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
        startTimer();
        
        // this is to receive app-go-to-sleep events
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        UIApplication.shared.isIdleTimerDisabled = true; // prevent iphone from going to sleep
        passedSimpleTimer_.start();
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        endAndCleanup();
        
    }
    
    func goBackToSetup(){
        performSegue(withIdentifier: "simpleToSetupSegue", sender: self);
    }
    
    func endAndCleanup(){
        UIApplication.shared.isIdleTimerDisabled = false; // allow iphone to go to sleep
        passedSimpleTimer_.setFinished(false);
    }
    
    func update() {
        minutesLabel.text = passedSimpleTimer_.getCurrentMinutes();
        secondsLabel.text = passedSimpleTimer_.getCurrentSeconds();
        if(passedSimpleTimer_.isFinished()){
            endAndCleanup()
            goBackToSetup();
        }
    }
    
    // handles app going to background :
    func willResignActive(_ notification: Notification) {
        // code to execute when app goes to background
        timeOnSleep_ = Date();
    }
    
    // handles app going to foreground :
    func willEnterForeground(_ notification: Notification) {
        // code to execute when app is back from backgorund
        let timeNow = Date();
        let timeDifference = timeNow.timeIntervalSince(timeOnSleep_); // this is the value in seconds
        passedSimpleTimer_.addTimeToTimer((Int(timeDifference)));
    }
}

