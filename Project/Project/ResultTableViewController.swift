//
//  ResultTableViewController.swift
//  Project
//
//  Created by formando on 06/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    var results: [Result] = [
        Result(id: 1, idHomeTeam: 1, nameHomeTeam: "Alqueidao", goalsHomeTeam: 2, goalsAwayTeam: 0, nameAwayTeam: "Mira de Aire", idAwayTeam: 2),
        Result(id: 1, idHomeTeam: 1, nameHomeTeam: "Alqueidao", goalsHomeTeam: 2, goalsAwayTeam: 0, nameAwayTeam: "Mira de Aire", idAwayTeam: 2),
        Result(id: 1, idHomeTeam: 1, nameHomeTeam: "Alqueidao", goalsHomeTeam: 2, goalsAwayTeam: 0, nameAwayTeam: "Mira de Aire", idAwayTeam: 2)
    ];
    let identifier = "ResultIdentifier";

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ResultTableViewCell;
        cell.homeTeamOutlet.setTitle(results[indexPath.row].nameHomeTeam, for: .normal);
        cell.awayTeamOutlet.setTitle(results[indexPath.row].nameAwayTeam, for: .normal);
        cell.homeTeamGoalsOutlet.text = String(results[indexPath.row].goalsHomeTeam);
        cell.awayTeamGoalsOutlet.text = String(results[indexPath.row].goalsAwayTeam);
        return cell;
    }
    
    // MARK: - Navigation
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToSend = leagues[indexPath.row].id;
        performSegue(withIdentifier: "goToClassification", sender: idToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? ClassificationTableViewController;
        info?.idLeagueReceived = self.idToSend;
    }*/
}
