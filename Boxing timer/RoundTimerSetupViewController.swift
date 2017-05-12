//
//  FirstViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class RoundTimerSetupViewController: UIViewController {

    // rounds information outlets
    @IBOutlet weak var roundInformationTitle: UILabel!
    @IBOutlet weak var roundInformationContainer: UIView!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    @IBOutlet weak var secondPerRoundLabel: UILabel!
    @IBOutlet weak var secondPerBreakLabel: UILabel!
    
    @IBOutlet weak var roundsStepper: UIStepper!
    @IBOutlet weak var secondPerRoundStepper: UIStepper!
    @IBOutlet weak var secondPerBreakStepper: UIStepper!
    @IBOutlet weak var editButtonView: UIView!
    
    
    @IBOutlet weak var numberOfRoundTitle: UILabel!
    @IBOutlet weak var secondPerRoundTitle: UILabel!
    @IBOutlet weak var secondPerBreakTitle: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    //timer variables
    var roundTimer = RoundTimer();
    
    // User Data memory
    var localMemoryManager_ = LocalMemoryManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberOfRoundsChanged(_ sender: UIStepper) {
        self.numberOfRoundsLabel.text = Int(sender.value).description;
        roundTimer.setNumberOfRounds(Int(sender.value));
    }

    @IBAction func secondPerRoundChanged(_ sender: UIStepper) {
        self.secondPerRoundLabel.text = Int(sender.value).description;
        roundTimer.setSecondPerRound(Int(sender.value));
    }

    @IBAction func secondPerBreakChanged(_ sender: UIStepper) {
        self.secondPerBreakLabel.text = Int(sender.value).description;
        roundTimer.setSecondPerBreak(Int(sender.value));
    }

    @IBAction func StartRounds(_ sender: AnyObject) {
        UIApplication.shared.isIdleTimerDisabled = true; // prevent iphone from going to sleep
        roundTimer.start();
        saveUserData();
    }
    
    func saveUserData(){
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER, value: roundTimer.getNumberOfRounds().description);
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION, value: roundTimer.getSecondPerRound().description);
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION, value: roundTimer.getSecondPerBreak().description);
    }
    
    func loadUserData(){
        let savedRoundNumber = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER);
        let savedRoundDuration = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION);
        let savedRoundBreakDuration = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION);
        
        if(savedRoundNumber != "") {
            roundsStepper.value = Double(savedRoundNumber)!;
            roundTimer.setNumberOfRounds(Int(savedRoundNumber)!);
            numberOfRoundsLabel.text = savedRoundNumber;
            
        }
        if(savedRoundDuration != "") {
            secondPerRoundStepper.value = Double(savedRoundDuration)!;
            roundTimer.setSecondPerRound(Int(savedRoundDuration)!);
            secondPerRoundLabel.text = savedRoundDuration;
        }
        if(savedRoundBreakDuration != "") {
            secondPerBreakStepper.value = Double(savedRoundBreakDuration)!;
            roundTimer.setSecondPerBreak(Int(savedRoundBreakDuration)!);
            secondPerBreakLabel.text = savedRoundBreakDuration;
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "setupToRoundSegue") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destination as! RoundTimerViewController;
            detailVC.passedRoundTimer_ = roundTimer;
        }
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
    
}

