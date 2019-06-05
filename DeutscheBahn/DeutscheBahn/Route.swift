//
//  Route.swift
//  DeutscheBahn
//
//  Created by Damian on 09/05/2019.
//  Copyright © 2019 Łojarze. All rights reserved.
//

import Foundation
class Route{
    var stationA:String
    var stationB:String
    var time:Date
    init(stationA:String,stationB:String,time:Date) {
        self.stationA = stationA
        self.stationB = stationB
        self.time = time
    }
}
