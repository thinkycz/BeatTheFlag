//
//  FlagModel.swift
//  BeatTheFlag
//
//  Created by Long Do Hai on 11.05.15.
//  Copyright (c) 2015 Long Do Hai. All rights reserved.
//

import Foundation

class FlagModel {
    var flagName: String?
    var flagImageName: String?
    var correct: Bool?
    
    init(flagName: String, flagImageName: String, correct: Bool)
    {
        self.flagName = flagName
        self.flagImageName = flagImageName
        self.correct = correct
    }
}