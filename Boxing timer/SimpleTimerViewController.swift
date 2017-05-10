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
    
    fileprivate var simpleTimerManager_ = simpleTimerManager();
    
    var viewUpdateTimer = Timer();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        UIApplication.shared.isIdleTimerDisabled = true; // prevent iphone from going to sleep
        simpleTimerManager_.start();
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        UIApplication.shared.isIdleTimerDisabled = false; // allow iphone to sleep
        simpleTimerManager_.end();
    }
    
    
    func update() {
        minutesLabel.text = simpleTimerManager_.getCurrentMinutes();
        secondsLabel.text = simpleTimerManager_.getCurrentSeconds();
        if(simpleTimerManager_.isFinished()){
            UIApplication.shared.isIdleTimerDisabled = false; // allow iphone to go to sleep
            simpleTimerManager_.setFinished(false);
        }
    }
}

