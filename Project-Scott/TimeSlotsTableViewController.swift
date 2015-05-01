//
//  TimeSlotsTableViewController.swift
//  Project-Scott
//
//  Created by edn-1 on 2015-04-24.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import UIKit

class TimeSlotsTableViewController: UITableViewController {
    
    var room: Room?
    
    @IBOutlet weak var myTitle: UINavigationItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var btnExit: UIButton!
    
    @IBAction func exit(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        //navBar.pushNavigationItem(myTitle, animated: false)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return room?.getName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return room!.getTimeslotsCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeslotCell") as! UITableViewCell
        
        cell.textLabel!.text = room?.getTimeslots()[indexPath.row].toString()
        // set cell's textLabel.text property
        // set cell's detailTextLabel.text property
        return cell
    }
}
