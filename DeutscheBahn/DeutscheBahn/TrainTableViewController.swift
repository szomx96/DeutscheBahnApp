//
//  TrainTableViewController.swift
//  DeutscheBahn
//
//  Created by Damian on 27/03/2019.
//  Copyright © 2019 Łojarze. All rights reserved.
//

import UIKit

class TrainTableViewController: UIViewController {
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var labelStationA: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelStationB: UILabel!
    var trains: [Train] = []
    var route: Route?
    override func viewDidLoad() {
        super.viewDidLoad()
        labelStationA?.text = route?.stationA
        labelStationB?.text = route?.stationB
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm dd.MM.yyyy"
        let time = dateFormatter.string(from: route!.time)
        labelTime?.text = time
        trains = createArray()
        // Do any additional setup after loading the view.
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
    }
    func createArray()->[Train]{
        return [Train(hour: "21:37", title: "Pociong"),
                Train(hour: "21:38", title: "Drugi pociong"),
                Train(hour: "21:39", title: "Trzeci pociong"),
                Train(hour: "21:40", title: "Czwarty pociong")
        ]
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   */

}
extension TrainTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trains.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let train = trains[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainItem") as! TrainCell
    
        cell.setTrain(train:train)
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "trainDetailsSegue", sender: self)
    }
}
