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

    
    fileprivate var simpleTimerInformation_ = SimpleTimerInformation();
    
    // User Data memory
    var userPrefManager_ = UserPreferencesManager();
    
        
    override func viewDidLoad() {
        super.viewDidLoad();
        loadUserData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "setupToSimpleSegue") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destination as! SimpleTimerViewController;
            detailVC.initSimpleTimer(passedTimerInformation: simpleTimerInformation_);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timerValueChanged(_ sender: UIStepper) {
        self.roundDurationValue.text = Int(sender.value).description;
        simpleTimerInformation_.totalDuration = Int(sender.value);
    }
    
    func saveUserData(){
        userPrefManager_.setValueForKey(BoxingTimerUserDataKeys.SIMPLE_TIMER_DURATION, value: simpleTimerInformation_.totalDuration.description);
    }
    
    func loadUserData(){
        let previousTotalDuration = userPrefManager_.getValueForKey(BoxingTimerUserDataKeys.SIMPLE_TIMER_DURATION);
        
        if(previousTotalDuration != "") {
            roundDurationStepper.value = Double(previousTotalDuration)!;
            simpleTimerInformation_.totalDuration = Int(previousTotalDuration)!;
            roundDurationValue.text = previousTotalDuration;
            
        }
    }
    
    @IBAction func startTimer(_ sender: AnyObject)
    {
        saveUserData();
        // navigate to simpleTimerViewController here
    }
}

