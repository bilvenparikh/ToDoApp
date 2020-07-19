//
//  Task.swift
//  ToDoApp
//
//  Created by 3Embed on 19/07/20.
//  Copyright © 2020 Bilven. All rights reserved.
//

import UIKit

class Task: Codable {
    var id = ""
    var name = ""
    var checked = false
    
    init (name: String) {
        self.id = UUID.init().uuidString
        self.name = name
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        name = (aDecoder.decodeObject(forKey:"name") as? String)!
        checked = (aDecoder.decodeObject(forKey:"checked") as? Bool)!
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(checked, forKey: "checked")
    }
}
