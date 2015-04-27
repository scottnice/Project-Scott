//
//  Connection.swift
//  Project-Scott
//
//  Created by edn-1 on 2015-04-23.
//  Copyright (c) 2015 edn-1. All rights reserved.
//

import Foundation


protocol DataReturnDelegate {
    func gotData(data: NSData?, error: String?)
}

class Connection : NSObject {
    var url: String!
    

    private var delegate: DataReturnDelegate!
    
    func getData() -> () {
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: url)!), queue: NSOperationQueue.currentQueue()) { response, data, error in
            if data != nil {
                self.delegate.gotData(data, error: nil)
            }
            else {
                self.delegate.gotData(nil, error: error.localizedDescription)
            }
        }
    }
    
    init(url: String, delegate: DataReturnDelegate) {
        self.url = url
        self.delegate = delegate
    }

}