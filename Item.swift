//
//  Item.swift
//  MyTodo
//
//  Created by Ipan Ardian on 4/28/16.
//  Copyright © 2016 Ipan Ardian. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name: String
    static let Dir = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = Dir.URLByAppendingPathComponent("items")
    
    // MARK: Actions
    
    init?(name: String) {
        self.name = name
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        self.init(name: name)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
    }
}