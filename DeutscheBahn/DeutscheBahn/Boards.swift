//
//  Boards.swift
//  HWDM
//
//  Created by RMS on 19.06.2019.
//  Copyright © 2019 RMS. All rights reserved.
//

import Foundation



struct Boards{
    let name : String
    let type : String
    let boardId : String
    let stopId : String
    let stopName : String
    let dateTime : String
    let origin : String
    let track : String
    let detailsId : String

    enum SerializationError:Error{
        case missing(String)
        case invalid(String, Any)
    }
    
    
    
    init(json:[String:Any]) throws {
        guard let name = json["name"] as? String else { throw SerializationError.missing("name is missing")}
        guard let type = json["type"] as? String else { throw SerializationError.missing("type is missing")}
        guard let boardId = json["boardId"] as? String else { throw SerializationError.missing("boardId is missing")}
        guard let detailsId = json["detailsId"] as? String else { throw SerializationError.missing("detailsId is missing")}
        guard let stopId = json["stopId"] as? String else { throw SerializationError.missing("stopId is missing")}
        guard let stopName = json["stopName"] as? String else { throw SerializationError.missing("stopName is missing")}
        guard let dateTime = json["dateTime"] as? String else { throw SerializationError.missing("dateTime is missing")}
        guard let origin = json["origin"] as? String else { throw SerializationError.missing("origin is missing")}
        guard let track = json["track"] as? String else { throw SerializationError.missing("track is missing")}
        self.name = name
        self.origin = origin
        self.boardId = boardId
        self.detailsId = detailsId
        self.stopId = stopId
        self.stopName = stopName
        self.dateTime = dateTime
        self.type = type
        self.track = track
    }
    
    static let basePath = "https://api.deutschebahn.com/freeplan/v1/"
    
    static func arrivalDetails (withLocation id:String, completion: @escaping ([Boards]) -> ()) {
        let url = basePath + "arrivalBoard/" + id
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var arrivalArray:[Boards] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let arrivalData = json["boards"] as? [[String:Any]] {
                            for dataPoint in arrivalData {
                                if let arrivalObject = try? Boards(json: dataPoint) {
                                    arrivalArray.append(arrivalObject)
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(arrivalArray)
            }
        }
        task.resume()
    }
    
    
    static func departureDetails (withLocation id:String, completion: @escaping ([Boards]) -> ()) {
        let url = basePath + "departureBoard/" + id
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var departureArray:[Boards] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let departureData = json["boards"] as? [[String:Any]] {
                            for dataPoint in departureData {
                                if let departureObject = try? Boards(json: dataPoint) {
                                    departureArray.append(departureObject)
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(departureArray)
            }
        }
        task.resume()
    }
}
