//
//  Observer.swift
//  Boxing timer
//
//  Created by Rodolphe Brossard on 2017-05-13.
//  Copyright © 2017 Rodolphe Brossard. All rights reserved.
//

import Foundation

protocol Observer {
    func update()
    var observerName : String {get set}
}
