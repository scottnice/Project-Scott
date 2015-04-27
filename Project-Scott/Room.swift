//
//  Room.swift
//  Project-Scott
//
//  Created by edn-1 on 2015-04-27.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import Foundation

class Room{
    private var timeslots: [Timeslot]
    private var name: String
    
    init(name: String){
        self.name = name
        timeslots = [Timeslot]()
    }
    
    init(json: JSON){
        name = json["name"].string!
        timeslots = Timeslot.parseJsonToArray(json)
    }
    
    func addTimeSlot(timeslot: Timeslot){
        timeslots.append(timeslot)
    }
    
    func getName() -> String{
        return name
    }
    
    func getTimeslots() -> [Timeslot]{
        return timeslots
    }
    
    static func parseJsonToArray(json: JSON) -> [Room]{
        var roomList = [Room]()
        for (index, roomDict) in json {
            roomList.append(Room(json: roomDict))
        }
        return roomList
    }
    
    func getTimeslotsCount() -> Int{
        return timeslots.count
    }
}