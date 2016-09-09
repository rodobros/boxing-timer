//
//  FirstViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

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
    
    // timer outlets
   
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var roundInformationLabel: UILabel!
    
    @IBOutlet weak var minutesTimerLabel: UILabel!
    @IBOutlet weak var separatorTimerLabel: UILabel!
    @IBOutlet weak var secondsTimerLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    //timer variables
    var roundTimerInformation = roundTimerManager();
    var viewUpdateTimer = NSTimer();
    
    // User Data memory
    var localMemoryManager_ = LocalMemoryManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
        loadUserData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberOfRoundsChanged(sender: UIStepper) {
        self.numberOfRoundsLabel.text = Int(sender.value).description;
        roundTimerInformation.setNumberOfRounds(Int(sender.value));
    }

    @IBAction func secondPerRoundChanged(sender: UIStepper) {
        self.secondPerRoundLabel.text = Int(sender.value).description;
        roundTimerInformation.setSecondPerRound(Int(sender.value));
    }

    @IBAction func secondPerBreakChanged(sender: UIStepper) {
        self.secondPerBreakLabel.text = Int(sender.value).description;
        roundTimerInformation.setSecondPerBreak(Int(sender.value));
    }

    @IBAction func StartRounds(sender: AnyObject) {
        UIApplication.sharedApplication().idleTimerDisabled = true; // prevent iphone from going to sleep
        toggleOutletsVisibility();
        roundTimerInformation.startRounds();
        saveUserData();
    }
    @IBAction func interruptRounds(sender: AnyObject) {
        UIApplication.sharedApplication().idleTimerDisabled = false;
        toggleOutletsVisibility();
        roundTimerInformation.endTimer();
    }
    
    func saveUserData(){
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER, value: roundTimerInformation.getNumberOfRounds().description);
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION, value: roundTimerInformation.getSecondPerRound().description);
        localMemoryManager_.setValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION, value: roundTimerInformation.getSecondPerBreak().description);
    }
    
    func loadUserData(){
        let savedRoundNumber = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_NUMBER);
        let savedRoundDuration = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_DURATION);
        let savedRoundBreakDuration = localMemoryManager_.getValueForKey(BoxingTimerUserDataKeys.ROUND_BREAK_DURATION);
        
        if(savedRoundNumber != "") {
            roundsStepper.value = Double(savedRoundNumber)!;
            roundTimerInformation.setNumberOfRounds(Int(savedRoundNumber)!);
            numberOfRoundsLabel.text = savedRoundNumber;
            
        }
        if(savedRoundDuration != "") {
            secondPerRoundStepper.value = Double(savedRoundDuration)!;
            roundTimerInformation.setSecondPerRound(Int(savedRoundDuration)!);
            secondPerRoundLabel.text = savedRoundDuration;
        }
        if(savedRoundBreakDuration != "") {
            secondPerBreakStepper.value = Double(savedRoundBreakDuration)!;
            roundTimerInformation.setSecondPerBreak(Int(savedRoundBreakDuration)!);
            secondPerBreakLabel.text = savedRoundBreakDuration;
        }
    }
    
    func toggleOutletsVisibility() {
        roundInformationContainer.hidden = !roundInformationContainer.hidden
        roundInformationTitle.hidden = !roundInformationTitle.hidden;
        numberOfRoundsLabel.hidden = !numberOfRoundsLabel.hidden;
        secondPerRoundLabel.hidden = !secondPerRoundLabel.hidden;
        secondPerBreakLabel.hidden = !secondPerBreakLabel.hidden;
        roundsStepper.hidden = !roundsStepper.hidden;
        secondPerRoundStepper.hidden = !secondPerRoundStepper.hidden;
        secondPerBreakStepper.hidden = !secondPerBreakStepper.hidden;
        numberOfRoundTitle.hidden = !numberOfRoundTitle.hidden;
        secondPerRoundTitle.hidden = !secondPerRoundTitle.hidden;
        secondPerBreakTitle.hidden = !secondPerBreakTitle.hidden;
        startButton.hidden = !startButton.hidden;
        editButtonView.hidden = !editButtonView.hidden;
        
        timerContainer.hidden = !timerContainer.hidden;
        roundInformationLabel.hidden = !roundInformationLabel.hidden;
        minutesTimerLabel.hidden = !minutesTimerLabel.hidden;
        separatorTimerLabel.hidden = !separatorTimerLabel.hidden;
        secondsTimerLabel.hidden = !secondsTimerLabel.hidden;
        stopButton.hidden = !stopButton.hidden;
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
            UIApplication.sharedApplication().idleTimerDisabled = false; // allow iphone to sleep
            toggleOutletsVisibility();
            roundTimerInformation.setFinished(false);
        }
    }
}

