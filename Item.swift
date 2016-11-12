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
    static let Dir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    // MARK: Actions
    
    init?(name: String) {
        self.name = name
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
}
