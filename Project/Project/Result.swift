//
//  Result.swift
//  Project
//
//  Created by formando on 06/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation
import UIKit

class Result: Codable {
    var id: Int;
    var idHomeTeam: Int;
    var nameHomeTeam: String;
    var goalsHomeTeam: Int;
    var goalsAwayTeam: Int;
    var nameAwayTeam: String;
    var idAwayTeam: Int;
    var weekMatch: Int
    
    init(id: Int, idHomeTeam: Int, nameHomeTeam: String, goalsHomeTeam: Int, idAwayTeam: Int, nameAwayTeam: String, goalsAwayTeam: Int, weekMatch: Int) {
        self.id = id;
        self.idHomeTeam = idHomeTeam;
        self.nameHomeTeam = nameHomeTeam;
        self.goalsHomeTeam = goalsHomeTeam;
        self.idAwayTeam = idAwayTeam;
        self.nameAwayTeam = nameAwayTeam;
        self.goalsAwayTeam = goalsAwayTeam;
        self.weekMatch = weekMatch
    }
    
    public var getDescription: String {
        return "id: \(id)\nidHomeTeam: \(idHomeTeam)\nnameHomeTeam: \(nameHomeTeam)\ngoalsHomeTeam: \(goalsHomeTeam)\nfidAwayTeam: \(idAwayTeam)\nnameAwayTeam: \(nameAwayTeam)\ngoalsAwayTeam: \(goalsAwayTeam)\nweekMatch: \(weekMatch)"
    }
}
