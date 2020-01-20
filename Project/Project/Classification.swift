//
//  Classification.swift
//  Project
//
//  Created by formando on 29/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation

class Classification: Codable {
    var idTeam: Int;
    var nameTeam: String;
    var games: Int;
    var points: Int;
    var victories: Int;
    var defeats: Int;
    var draws: Int;
    var goalsScored: Int;
    var goalsConceded: Int;
    var differenceGoals: Int;
    
    init(idTeam: Int, nameTeam: String, games: Int, points: Int, victories: Int, defeats: Int, draws: Int, goalsScored: Int, goalsConceded: Int, differenceGoals: Int) {
        self.idTeam = idTeam;
        self.nameTeam = nameTeam;
        self.games = games;
        self.points = points;
        self.victories = victories;
        self.defeats = defeats;
        self.draws = draws;
        self.goalsScored = goalsScored;
        self.goalsConceded = goalsConceded;
        self.differenceGoals = differenceGoals;
    }
    
    public var getDescription: String {
        return "idTeam: \(idTeam)\nnameTeam: \(nameTeam)\ngames: \(games)\npoints: \(points)\nvictories: \(victories)\ndefeats: \(defeats)\ndraws: \(draws)\ngoalsScored: \(goalsScored)\ngoalsConceded: \(goalsConceded)\ndifferenceGoals: \(differenceGoals)"
    }
}
