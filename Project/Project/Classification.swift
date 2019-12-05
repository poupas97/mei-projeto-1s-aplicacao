//
//  Classification.swift
//  Project
//
//  Created by formando on 29/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation

class Classification {
    var idTeam: Int;
    var nameTeam: String;
    var points: Int;
    
    init(idTeam: Int, nameTeam: String, points: Int) {
        self.idTeam = idTeam;
        self.nameTeam = nameTeam;
        self.points = points;
    }
}
