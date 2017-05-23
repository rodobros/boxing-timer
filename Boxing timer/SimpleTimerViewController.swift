//
//  SimpleTimerViewController.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-09.
//  Copyright © 2016 Rodolphe Brossard. All rights reserved.
//

import UIKit

class SimpleTimerViewController: UIViewController, Observer {
    
    internal var observerName = "SimpleTimerObserver";
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerTitle: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var timerSeparator: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    private var simpleTimer_ : SimpleTimer?; // timer that will received from setup viewController

    
    func initSimpleTimer(passedTimerInformation : SimpleTimerInformation) {
        simpleTimer_ = SimpleTimer(view: self, info: passedTimerInformation);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //viewUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(update), userInfo:nil, repeats:true);
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
        allowPhoneToSleep(false); // prevent iphone from going to sleep
        simpleTimer_!.start();
    }
    
    @IBAction func stopButtonClicked(_ sender: AnyObject) {
        allowPhoneToSleep(true);
        simpleTimer_!.end();
    }
    
    func goBackToSetupViewController(){
        performSegue(withIdentifier: "simpleToSetupSegue", sender: self);
    }
    
    func allowPhoneToSleep(_ value : Bool){
        UIApplication.shared.isIdleTimerDisabled = !value; // allow iphone to go to sleep
    }
    
    // Observer pattern required function
    func update() {
        minutesLabel.text = simpleTimer_!.getCurrentMinutes();
        secondsLabel.text = simpleTimer_!.getCurrentSeconds();
        if(simpleTimer_!.isFinished()){
            allowPhoneToSleep(true);
            goBackToSetupViewController();
        }
    }
    
    
    // handles app going to background :
    func willResignActive(_ notification: Notification) {
        simpleTimer_!.notifyAppWillResign();
    }
    
    // handles app going to foreground :
    func willEnterForeground(_ notification: Notification) {
        simpleTimer_!.notifyAppWillEnterForeground();
    }
    
    // override to go back to a specific tab
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "simpleToSetupSegue") {
            let tabBar = segue.destination as! UITabBarController;
            tabBar.selectedIndex = 1; // simple timer tab
        }
    }
}

