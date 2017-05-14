//
//  RoundTimerInformation.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-13.
//  Copyright © 2017 Rodolphe Brossard. All rights reserved.
//

import Foundation

struct RoundTimerInformation {
    var numberOfRounds = 3;
    var secondPerRound = 180;
    var secondPerBreak = 60;
    var secondPerGetReady = 5;
    var currentRound = 1;
    var isBreak = false;
    var isGetReady = false;
}
