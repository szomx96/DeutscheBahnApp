//
//  Train_locs.swift
//  HWDM
//
//  Created by RMS on 19.06.2019.
//  Copyright © 2019 RMS. All rights reserved.
//

import Foundation

struct Train_locs {
    let stopId : String
    let stopName : String
    let lat : Float
    let lon : Float
    let arrTime : String
    let depTime : String
    let train : String
    let type : String
    let operatorString : String
 
    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let stopId = json["stopId"] as? String else { throw SerializationError.missing("stopId is missing")}
        guard let stopName = json["stopName"] as? String else { throw SerializationError.missing("stopName is missing")}
        guard let lon = json["lon"] as? Float else { throw SerializationError.missing("lon is missing")}
        guard let lat = json["lat"] as? Float else { throw SerializationError.missing("lat is missing")}
        guard let arrTime = json["arrTime"] as? String else { throw SerializationError.missing("arrTime is missing")}
        guard let depTime = json["depTime"] as? String else { throw SerializationError.missing("depTime is missing")}
        guard let train = json["train"] as? String else { throw SerializationError.missing("train is missing")}
        guard let type = json["type"] as? String else { throw SerializationError.missing("type is missing")}
        guard let operatorString = json["operatorString"] as? String else { throw SerializationError.missing("operatorString is missing")}
        self.stopId = stopId
        self.stopName = stopName
        self.lon = lon
        self.lat = lat
        self.arrTime = arrTime
        self.depTime = depTime
        self.train = train
        self.type = type
        self.operatorString = operatorString
    }
    
    static let basePath = "https://api.deutschebahn.com/freeplan/v1/journeyDetails/"
    
    static func trainDetails (withLocation id:String, completion: @escaping ([Train_locs]) -> ()) {
        let url = basePath + id
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var trainsArray:[Train_locs] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let trainData = json["train_locs"] as? [[String:Any]] {
                            for dataPoint in trainData {
                                if let trainObject = try? Train_locs(json: dataPoint) {
                                    trainsArray.append(trainObject)
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(trainsArray)
            }
        }
        task.resume()
    }

}
