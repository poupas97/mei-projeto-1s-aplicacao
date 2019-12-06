//
//  ClassificationTableViewController.swift
//  Project
//
//  Created by formando on 27/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//


// https://www.youtube.com/watch?v=TCj3qe5zKlc

import UIKit

var arrayClassifications: [Classification] = [];

class ClassificationTableViewController: UITableViewController {

    var idLeagueReceived: Int = 0;
    var idTeamToSend = 0;
    var position: Int = 0;
    var weekMatch: Int = 0;
    
    @IBOutlet var classifications: UITableView!
    
    let identifier = "ClassificationIdentifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayClassifications = [Classification(idTeam: 1, nameTeam: "alq", points: 18), Classification(idTeam: 2, nameTeam: "pdm", points: 15)];
        position = 1;
        weekMatch = 1;
        classifications.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayClassifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ClassificationTableViewCell;
        cell.classificationOutlet.text = String(position);
        cell.teamOutlet.text = arrayClassifications[indexPath.row].nameTeam;
        cell.pointsOutlet.text = String(arrayClassifications[indexPath.row].points);
        cell.weekMatchOutlet.text = String(weekMatch);
        position = position + 1;
        return cell;
    }

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idTeamToSend = arrayClassifications[indexPath.row].idTeam;
        performSegue(withIdentifier: "goToTeamView", sender: idTeamToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? TeamViewController;
        info?.idTeamReceived = self.idTeamToSend;
    }

}
