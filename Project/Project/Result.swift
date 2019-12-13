//
//  Result.swift
//  Project
//
//  Created by formando on 06/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation
import UIKit

class Result {
    var id: Int;
    var idHomeTeam: Int;
    var nameHomeTeam: String;
    var goalsHomeTeam: Int;
    var goalsAwayTeam: Int;
    var nameAwayTeam: String;
    var idAwayTeam: Int;
    
    init(id: Int, idHomeTeam: Int, nameHomeTeam: String, goalsHomeTeam: Int, goalsAwayTeam: Int, nameAwayTeam: String, idAwayTeam: Int) {
        self.id = id;
        self.idHomeTeam = idHomeTeam;
        self.nameHomeTeam = nameHomeTeam;
        self.goalsHomeTeam = goalsHomeTeam;
        self.goalsAwayTeam = goalsAwayTeam;
        self.nameAwayTeam = nameAwayTeam;
        self.idAwayTeam = idAwayTeam;
    }
}
