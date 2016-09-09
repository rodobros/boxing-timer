//
//  SecondViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var timerInfoView: UIView!
    @IBOutlet weak var timerInfoTitle: UILabel!
    @IBOutlet weak var roundDurationStepper: UIStepper!
    @IBOutlet weak var roundDurationValue: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var roundDurationLabel: UILabel!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerTitle: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var timerSeparator: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    private var simpleTimerManager_ = simpleTimerManager();
    
    var viewUpdateTimer = NSTimer();
        
    override func viewDidLoad() {
        super.viewDidLoad();
        viewUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timerValueChanged(sender: UIStepper) {
        self.roundDurationValue.text = Int(sender.value).description;
        simpleTimerManager_.setTotalDuration(Int(sender.value));
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        UIApplication.sharedApplication().idleTimerDisabled = true; // prevent iphone from going to sleep
        toggleOutletsVisibility();
        simpleTimerManager_.start();
    }
    
    @IBAction func stopTimer(sender: AnyObject) {
        UIApplication.sharedApplication().idleTimerDisabled = false; // allow iphone to sleep
        toggleOutletsVisibility();
        simpleTimerManager_.end();
    }
    
    func toggleOutletsVisibility() {
        timerInfoView.hidden = !timerInfoView.hidden;
        timerView.hidden = !timerView.hidden;
    }

    func update() {
        minutesLabel.text = simpleTimerManager_.getCurrentMinutes();
        secondsLabel.text = simpleTimerManager_.getCurrentSeconds();
        if(simpleTimerManager_.isFinished()){
            UIApplication.sharedApplication().idleTimerDisabled = false; // allow iphone to go to sleep
            toggleOutletsVisibility();
            simpleTimerManager_.setFinished(false);
        }
    }
}

