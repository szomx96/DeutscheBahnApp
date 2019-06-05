//
//  MainViewController.swift
//  DeutscheBahn
//
//  Created by Damian on 08/05/2019.
//  Copyright © 2019 Łojarze. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var labelStationA: UITextField!
    @IBOutlet weak var labelStationB: UITextField!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let route = Route(stationA: labelStationA.text ?? "",stationB: labelStationB.text ?? "", time: dateTimePicker.date)
        guard let trainTableViewController = segue.destination as? TrainTableViewController
            else {return}
        trainTableViewController.route = route
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
