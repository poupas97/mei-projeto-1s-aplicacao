//
//  Team.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation
import UIKit

class Team: Codable {
    var id: Int = 0;
    var name: String = "";
    var city: String = "";
    var president: String = "";
    var fundationYear: Int = 0;
    var equipmentBrand: String = "";
    var idAssociation: Int = 0;
    var points: Int = 0;
    var matchWeek: Int = 0;
    var victories: Int = 0;
    var drawers: Int = 0;
    var defeats: Int = 0;
    var goalsScored: Int = 0;
    var goalsConceded: Int = 0;
    var goalsDeference: Int = 0;
    
    init() {
    }
    
    init(id: Int, name: String, city: String, president: String, fundationYear: Int, equipmentBrand: String, idAssociation: Int) {
        self.id = id;
        self.name = name;
        self.city = city;
        self.president = president;
        self.fundationYear = fundationYear;
        self.equipmentBrand = equipmentBrand;
        self.idAssociation = idAssociation;
    }
    
    init(id: Int, name: String, city: String, president: String, fundationYear: Int, equipmentBrand: String, idAssociation: Int, points: Int, matchWeek: Int, victories: Int, drawers: Int, defeats: Int, goalsScored: Int, goalsConceded: Int, goalsDeference: Int) {
        self.id = id;
        self.name = name;
        self.city = city;
        self.president = president;
        self.fundationYear = fundationYear;
        self.equipmentBrand = equipmentBrand;
        self.idAssociation = idAssociation;
        self.points = points
        self.matchWeek = matchWeek
        self.victories = victories
        self.drawers = drawers
        self.defeats = defeats
        self.goalsScored = goalsScored
        self.goalsConceded = goalsConceded
        self.goalsDeference = goalsDeference
    }
    
    public var getDescription: String {
        return "id: \(id)\nname: \(name)\ncity: \(city)\npresident: \(president)\nfundationYear: \(fundationYear)\nequipmentBrand: \(equipmentBrand)\nidAssociation: \(idAssociation)"
    }
}
