//
//  SecondViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class SimpleTimerSetupViewController: UIViewController {

    @IBOutlet weak var timerInfoView: UIView!
    @IBOutlet weak var timerInfoTitle: UILabel!
    @IBOutlet weak var roundDurationStepper: UIStepper!
    @IBOutlet weak var roundDurationValue: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var roundDurationLabel: UILabel!

    
    fileprivate var simpleTimerManager_ = simpleTimerManager();
    
        
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timerValueChanged(_ sender: UIStepper) {
        self.roundDurationValue.text = Int(sender.value).description;
        simpleTimerManager_.setTotalDuration(Int(sender.value));
    }
    
    @IBAction func startTimer(_ sender: AnyObject)
    {
        // navigate to simpleTimerViewController here
    }
}

