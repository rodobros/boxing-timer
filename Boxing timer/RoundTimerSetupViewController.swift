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
    var roundTimerInformation_ = RoundTimerInformation();
    
    // User Data memory
    var userPrefManager_ = UserPreferencesManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startButtonClicked(_ sender: Any) {
        saveUserData()
    }
    
    @IBAction func numberOfRoundsChanged(_ sender: UIStepper) {
        self.numberOfRoundsLabel.text = Int(sender.value).description;
        roundTimerInformation_.numberOfRounds = Int(sender.value);
    }

    @IBAction func secondPerRoundChanged(_ sender: UIStepper) {
        self.secondPerRoundLabel.text = Int(sender.value).description;
        roundTimerInformation_.secondPerRound = Int(sender.value);
    }

    @IBAction func secondPerBreakChanged(_ sender: UIStepper) {
        self.secondPerBreakLabel.text = Int(sender.value).description;
        roundTimerInformation_.secondPerBreak = Int(sender.value);
    }
    
    func saveUserData(){
        userPrefManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER, value: roundTimerInformation_.numberOfRounds.description);
        userPrefManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION, value: roundTimerInformation_.secondPerRound.description);
        userPrefManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION, value: roundTimerInformation_.secondPerBreak.description);
    }
    
    func loadUserData(){
        let savedRoundNumber = userPrefManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER);
        let savedRoundDuration = userPrefManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION);
        let savedRoundBreakDuration = userPrefManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION);
        
        if(savedRoundNumber != "") {
            roundsStepper.value = Double(savedRoundNumber)!;
            roundTimerInformation_.numberOfRounds = Int(savedRoundNumber)!;
            numberOfRoundsLabel.text = savedRoundNumber;
            
        }
        if(savedRoundDuration != "") {
            secondPerRoundStepper.value = Double(savedRoundDuration)!;
            roundTimerInformation_.secondPerRound = Int(savedRoundDuration)!;
            secondPerRoundLabel.text = savedRoundDuration;
        }
        if(savedRoundBreakDuration != "") {
            secondPerBreakStepper.value = Double(savedRoundBreakDuration)!;
            roundTimerInformation_.secondPerBreak = Int(savedRoundBreakDuration)!;
            secondPerBreakLabel.text = savedRoundBreakDuration;
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "setupToRoundSegue") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destination as! RoundTimerViewController;
            detailVC.initRoundTimer(passedTimerInformation: roundTimerInformation_);
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

