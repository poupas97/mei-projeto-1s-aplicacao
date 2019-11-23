//
//  FavoriteTeamTableViewController.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

// https://www.youtube.com/watch?v=MOoLfHTTNDs

import UIKit

class FavoriteTeamTableViewController: UITableViewController {

    var favoriteTeams: [Team] = [Team(id: 1, name: "alq"), Team(id: 2, name: "pdm")];
    let identifier = "FavoriteTeamIdentifier";
    var idToSend: Int = 0;
    
    @IBOutlet var favTeams: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTeams.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FavoriteTeamTableViewCell;
        cell.labelOutlet.text = favoriteTeams[indexPath.row].name;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectedRowat", favoriteTeams[indexPath.row].id);
        idToSend = favoriteTeams[indexPath.row].id;
        performSegue(withIdentifier: "goToTeamView", sender: favoriteTeams[indexPath.row].id);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? TeamViewController;
        info?.idTeam = self.idToSend;
    }



}
