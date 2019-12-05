//
//  FavoriteTeamTableViewController.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

// https://www.youtube.com/watch?v=MOoLfHTTNDs

import UIKit

let teams: [Team] = [Team(id: 1, name: "alq"), Team(id: 2, name: "ansiao"), Team(id: 3, name: "pdm"), Team(id: 4, name: "leiria")];
var idTeamsArray: [Int] = [];
var favoriteTeams: [Team] = [];
let fileName = "FavoriteTeams.txt"

class FavoriteTeamTableViewController: UITableViewController {
    
    @IBOutlet var favTeams: UITableView!
    
    let identifier = "FavoriteTeamIdentifier";
    var idTeamToSend: Int = 0;
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        favTeams.delegate = self
        getTeams();
        writeToFile();
        readFromFile();
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
    
    // MARK: - Methods
    
    private func existIdInTeams(team: Team) -> Bool {
        return idTeamsArray.contains(team.id);
    }
    
    private func getTeams () {
        // TODO
        favoriteTeams.append(teams[1]);
        favoriteTeams.append(teams[2])
    }
    
    // MARK: - Actions
    
    public func addFavoritTeam(teamReceived: Team) {
        if (!existIdInTeams(team: teamReceived)) {
            favoriteTeams.append(teamReceived);
            idTeamsArray.append(teamReceived.id);
        }
    }
    
    public func removeFavoritTeam(teamReceived: Team) {
        if (existIdInTeams(team: teamReceived)) {
            favoriteTeams = favoriteTeams.filter({$0 !== teamReceived});
            idTeamsArray.remove(at: idTeamsArray.firstIndex(of: teamReceived.id)!);
        }
    }
    
    // MARK: - Files
    
    private func writeToFile () {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                (idTeamsArray as NSArray).write(to: fileURL, atomically: true)
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while adding favorite team", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func readFromFile () {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                idTeamsArray = NSArray(contentsOf: fileURL) as! [Int]
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while reading favorite teams", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        // TODO: remove
        idTeamsArray = [1, 3];
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idTeamToSend = favoriteTeams[indexPath.row].id;
        performSegue(withIdentifier: "goToTeamView", sender: idTeamToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? TeamViewController;
        info?.idTeamReceived = self.idTeamToSend;
        info?.isFavotiteTeam = true;
    }

}
