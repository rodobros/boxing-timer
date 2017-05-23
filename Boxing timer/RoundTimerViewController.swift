//
//  FirstViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2016-09-06.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class RoundTimerViewController: UIViewController, Observer {
    
    internal var observerName = "RoundTimerObserver";
    
    // timer outlets
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var roundInformationLabel: UILabel!
    
    @IBOutlet weak var minutesTimerLabel: UILabel!
    @IBOutlet weak var separatorTimerLabel: UILabel!
    @IBOutlet weak var secondsTimerLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    //timer variables
    private var roundTimer_ : RoundTimer?
    
    private var timeOnSleep_ = Date();
    
    func initRoundTimer(passedTimerInformation : RoundTimerInformation) {
        roundTimer_ = RoundTimer(view: self, info: passedTimerInformation);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
        startRounds();
        
        // this is to receive app-go-to-sleep events
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRounds() {
        allowPhoneToSleep(false) // prevent iphone from going to sleep
        roundTimer_!.start();
    }
    
    @IBAction func interruptRounds(sender: AnyObject) {
        // pause timer here
    }
    
    @IBAction func stopButtonClick(_ sender: Any) {
        allowPhoneToSleep(true);
        roundTimer_!.end();
    }
    
    private func allowPhoneToSleep(_ value : Bool){
        UIApplication.shared.isIdleTimerDisabled = !value; // allow iphone to sleep
    }
    
    private func goBackToSetupViewController(){
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
    
    // Observer function
    func update() {
        minutesTimerLabel.text = roundTimer_!.getCurrentMinutes();
        secondsTimerLabel.text = roundTimer_!.getCurrentSeconds();
        if(roundTimer_!.isBreak()){
            if(roundTimer_!.isGetReady()){
                roundInformationLabel.text = "Get ready!";
                yellowBackground()
            } else {
                whiteBackground()
                roundInformationLabel.text = "Break";
            }
        } else {
            whiteBackground()
            roundInformationLabel.text = "Round " + roundTimer_!.getCurrentRound().description;
        }
        if(roundTimer_!.isFinished()){
            allowPhoneToSleep(true);
            goBackToSetupViewController();
        }
    }
    
    // handles app going to background :
    func willResignActive(_ notification: Notification) {
        roundTimer_!.notifyAppWillResign();
    }
    
    // handles app going to foreground :
    func willEnterForeground(_ notification: Notification) {
        roundTimer_!.notifyAppWillEnterForeground();
    }
    
    // override to go back to a specific tab
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "roundToSetupSegue") {
            let tabBar = segue.destination as! UITabBarController;
            tabBar.selectedIndex = 0; // round timer tab
        }
    }
}

