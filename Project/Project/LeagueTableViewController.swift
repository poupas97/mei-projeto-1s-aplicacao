//
//  LeagueTableViewController.swift
//  Project
//
//  Created by formando on 21/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {

    @IBOutlet var leagueTableView: UITableView!
    
    var leagues: [League] = [League(id: 1, name: "honra"), League(id: 2, name: "serie a")];
    let identifier = "LeagueIdentifier";
    var idToSend: Int = 0;
    var idReceived: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTableView.delegate = self
        
        print(idReceived)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! LeagueTableViewCell;
        cell.labelOutlet.text = leagues[indexPath.row].name;
        return cell;
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToSend = leagues[indexPath.row].id;
        performSegue(withIdentifier: "goToClassification", sender: idToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? ClassificationTableViewController;
        print(info);
        info?.idLeagueReceived = self.idToSend;
    }
}
