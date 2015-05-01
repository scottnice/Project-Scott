//
//  Timeslot.swift
//  Project-Scott
//
//  Created by edn-1 on 2015-04-27.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import Foundation

class Timeslot{
    
    var id: Int
    var start_time: String
    var end_time: String
    var day: String
    
    static func parseJsonToArray(json: JSON) -> [Timeslot]{
        var timeslotArray = [Timeslot]()
        for(index, timeslotDictionary) in json["timeslots"] {
            var number = timeslotDictionary["id"].number ?? 0
            var start_time = timeslotDictionary["start_time"].string ?? ""
            var end_time = timeslotDictionary["end_time"].string ?? ""
            var day = timeslotDictionary["day"].string ?? ""
            
            if timeslotDictionary.error != nil {
                var error = NSError()
                NSException.raise("Exception", format:"Error: %@", arguments:getVaList([error]))
            }
            
            timeslotArray.append(Timeslot(id: Int(number), start_time: start_time, end_time: end_time, day: day))
        }
        return timeslotArray
    }
    
    init(id: Int, start_time: String, end_time: String, day: String){
        self.id = id
        self.start_time = start_time
        self.end_time = end_time
        self.day = day
    }
    
    func toString() -> String{
        var output = ""
        var format = parseDateStringToTimeString
        return format(start_time) + " " + format(end_time) + " " + day
    }
    
    private func parseDateStringToTimeString(date: String) -> String{
        var convertedDate = convertStringToDate(date)
        var format = NSDateFormatter()
        format.timeZone = NSTimeZone(abbreviation: "UTC")
        format.dateFormat = "h:mm a"
        
        if convertedDate != nil{
            return format.stringFromDate(convertedDate!)
        }
        else{
            return ""
        }
    }
    
    private func convertStringToDate(date: String) -> NSDate?{
        var format = NSDateFormatter()
        format.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.sZ"
        return format.dateFromString(date)
    }
    
}