//
//  Association.swift
//  Project
//
//  Created by formando on 18/01/2020.
//  Copyright © 2020 ipleiria. All rights reserved.
//

import Foundation

class Association: Codable {
    var id: Int;
    var name: String;
    
    init(id: Int, name: String) {
        self.id = id;
        self.name = name;
    }
    
    init() {
        self.id = 0;
        self.name = "";
    }
    
    public var getDescription: String {
        return "id: \(id)\nname: \(name)"
    }
}
