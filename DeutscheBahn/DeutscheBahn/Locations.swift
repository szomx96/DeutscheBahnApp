//
//  Locations.swift
//  HWDM
//
//  Created by RMS on 19.06.2019.
//  Copyright © 2019 RMS. All rights reserved.
//

import Foundation

struct Locations {
    let id: String
    let name: String
    let lon: Float
    let lat: Float
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let id = json["id"] as? String else { throw SerializationError.missing("id is missing")}
        guard let name = json["name"] as? String else { throw SerializationError.missing("name is missing")}
        guard let lon = json["lon"] as? Float else { throw SerializationError.missing("lon is missing")}
        guard let lat = json["lat"] as? Float else { throw SerializationError.missing("lat is missing")}
        
        self.id = id
        self.name = name
        self.lon = lon
        self.lat = lat
    }
    
    static let basePath = "https://api.deutschebahn.com/freeplan/v1/location/"
    
    static func locationDetails (withLocation location:String, completion: @escaping ([Locations]) -> ()) {
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var locationArray:[Locations] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let locationData = json["locations"] as? [[String:Any]] {
                                for dataPoint in locationData {
                                    if let locationsObject = try? Locations(json: dataPoint) {
                                        locationArray.append(locationsObject)
                                    }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(locationArray)
            }
        }
        task.resume()
    }
}
