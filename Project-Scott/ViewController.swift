//
//  ViewController.swift
//  Project-Scott
//
//  Created by edn-1 on 2015-04-23.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataReturnDelegate {
    
    var dataSourceArray = [Room]()
    var selectedRoom: Room? = nil
    @IBOutlet weak var output: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func GetEmptyRoomData(sender: UIButton){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitWeekday, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.weekday - 1
        
        var conn = Connection(url: "http://hidden-earth-7822.herokuapp.com/find_empty_rooms/\(day)/\(hour):\(minutes):00.json", delegate: self)
        println("http://hidden-earth-7822.herokuapp.com/find_empty_rooms/\(day)/\(hour):\(minutes):00.json")
        conn.getData()
    }
    
    @IBAction func GetRoomData(sender: UIButton) {
        var conn = Connection(url: "http://hidden-earth-7822.herokuapp.com/display_rooms.json", delegate: self)
        conn.getData()
    }
    
    var numberOfTableRows: Int = 0
    
    func gotData(data: NSData?, error: String?) {
        println(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
        
        formatJsonRoomData(data!)
        getRoomArray(data!)
        
        tableView.reloadData()
    }
    
    func formatJsonRoomData(data: NSData) -> String{
        let json = JSON(data: data)
        var message: String = ""
        for (index, roomDict) in json {
            message += "Room Name:" + roomDict["name"].string! + "\n"
            numberOfTableRows = json.count
            for(index, timeslotDictionary) in roomDict["timeslots"] {
                var number = timeslotDictionary["id"].number!
                var start_time = timeslotDictionary["start_time"].string!
                var end_time = timeslotDictionary["end_time"].string!
                var day = timeslotDictionary["day"].string!
                message += "ID: " + number.stringValue + "\n"
                message += "Start Time: " + start_time + "\n"
                message += "End Time: " + end_time + "\n"
                message += "Day: " + day + "\n"
            }
        }
        println(message)
        return message
    }
    
    func getRoomArray(data: NSData){
        var json = JSON(data: data)
        dataSourceArray = Room.parseJsonToArray(json)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count // Most of the time my data source is an array of something...  will replace with the actual name of the data source
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoomCell") as! UITableViewCell
        
        
        cell.textLabel!.text = dataSourceArray[indexPath.row].getName()
        // set cell's textLabel.text property
        // set cell's detailTextLabel.text property
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Timeslots") {
            var vc = segue.destinationViewController as! TimeSlotsTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            vc.room = dataSourceArray[indexPath!.row]
        }
    }


}

