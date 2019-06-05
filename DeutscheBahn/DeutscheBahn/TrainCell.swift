//
//  TrainCell.swift
//  DeutscheBahn
//
//  Created by Damian on 27/03/2019.
//  Copyright © 2019 Łojarze. All rights reserved.
//

import UIKit

class TrainCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    func setTrain(train:Train){
        titleLabel.text = train.title
        hourLabel.text = train.hour
    }
}
