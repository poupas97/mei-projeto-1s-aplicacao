//
//  FavoriteTeamTableViewController.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

// https://www.youtube.com/watch?v=MOoLfHTTNDs

import UIKit

var favoriteTeams: [Team] = [];

class FavoriteTeamTableViewController: UITableViewController {
    
    @IBOutlet var favTeams: UITableView!
    
    let identifier = "FavoriteTeamIdentifier";
    var idToSend: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTeams = [Team(id: 1, name: "alq"), Team(id: 2, name: "pdm")];
        favTeams.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favTeams.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
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
    
    // MARK: - Actions
    
    public func addFavoritTeam(teamReceived: Team) {
        favoriteTeams.append(teamReceived);
    }
    
    public func removeFavoritTeam(teamReceived: Team) {
        let index = find(teamReceived, favoriteTeams);
        print(index);
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToSend = favoriteTeams[indexPath.row].id;
        performSegue(withIdentifier: "goToTeamView", sender: idToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? TeamViewController;
        print(info);
        info?.idTeamReceived = self.idToSend;
    }

}
