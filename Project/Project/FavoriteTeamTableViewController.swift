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
let fileName = "FavoriteTeams.txt"

class FavoriteTeamTableViewController: UITableViewController {
    
    @IBOutlet var favTeams: UITableView!
    
    let identifier = "FavoriteTeamIdentifier";
    var idTeamToSend: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTeams = [Team(id: 1, name: "alq"), Team(id: 2, name: "ansiao"), Team(id: 3, name: "pdm"), Team(id: 4, name: "leiria")];
        favTeams.delegate = self
        writeToFile(array: [8]);
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
    
    // MARK: - Actions
    
    public func addFavoritTeam(teamReceived: Team) {
        favoriteTeams.append(teamReceived);
    }
    
    public func removeFavoritTeam(teamReceived: Team) {
        favoriteTeams = favoriteTeams.filter({$0 !== teamReceived});
    }
    
    // MARK: - Files
    
    private func writeToFile (array: [Int]) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                //try text.write(to: fileURL, atomically: false, encoding: .utf8)
                (array as NSArray).write(to: fileURL, atomically: true)
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while adding favorite team", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func readFromFile () -> [Int] {
        var finalArray: [Int] = []
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                //finalArray = stringToArray(text: text);
                print(NSArray(contentsOf: fileURL) as! [Int])
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while reading favorite teams", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        return finalArray;
    }
    
    
    private func stringToArray (text: String) -> [Int] {
        return text.components(separatedBy: ";").filter({!$0.isEmpty}).map({ Int($0)! });
    }
    
    private func arrayToString (array: [Int]) -> String {
        var text = "";
        for a in array {
            text.append(String(a))
        }
        return text;
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
