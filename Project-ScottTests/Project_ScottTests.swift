//
//  Project_ScottTests.swift
//  Project-ScottTests
//
//  Created by edn-1 on 2015-04-23.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import UIKit
import XCTest
import Quick
import Nimble
import Project_Scott

class Project_ScottTests: QuickSpec, DataReturnDelegate {
    
    var error: String?
    var data: NSData?
    
    override func spec() {
        describe("Connection") {
            
            it("It has an error when the url is bad"){
                
                var conn = Connection(url: "http://hidden-earth-7822.herokuapp.garbage", delegate: self)
                conn.getData()
                expect(self.error).toEventuallyNot(beNil(), timeout: NSTimeInterval(10), pollInterval: NSTimeInterval(0.5))
            }
            
            it("It gets data from websites"){
                
                var conn = Connection(url: "http://hidden-earth-7822.herokuapp.com/display_rooms.json", delegate: self)
                conn.getData()
                expect(self.data).toEventuallyNot(beNil(), timeout: NSTimeInterval(10), pollInterval: NSTimeInterval(0.5))
            }
        }
        
        describe("Room"){
            it("parses json data"){
                var json = JSON(data: self.data!)
                expect(Room(json: json[0])).toNot(raiseException())
            }
        }
    }
    func gotData(data: NSData?, error: String?) {
        self.data = data
        self.error = error
    }
    
}
