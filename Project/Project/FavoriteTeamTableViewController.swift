//
//  FavoriteTeamTableViewController.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

// https://www.youtube.com/watch?v=MOoLfHTTNDs

import UIKit

let fileName = "FavoriteTeams.txt"

class FavoriteTeamTableViewController: UITableViewController {
    
    // MARK: - VAR
    
    @IBOutlet var favTeams: UITableView!
    
    let identifier = "FavoriteTeamIdentifier";
    var idTeamToSend: Int = 0;
    var favoriteTeams: [Team] = [];
    var idTeamsArray: [Int] = [];
    
    // MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        favTeams.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTeams()
        favTeams.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TABLE VIEW DATA SOURCE
    
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
    
    // MARK: - METHODS
    
    public func existInTeams(team: Team) -> Bool {
        readFromFile()
        return idTeamsArray.contains(team.id);
    }
    
    public func addFavoritTeam(teamReceived: Team) {
        if (!existInTeams(team: teamReceived)) {
            print("ADD TEAM")
            idTeamsArray.append(teamReceived.id);
            writeToFile()
        }
    }
    
    public func removeFavoritTeam(teamReceived: Team) {
        if (existInTeams(team: teamReceived)) {
            print("REMOVE TEAM")
            idTeamsArray.remove(at: idTeamsArray.firstIndex(of: teamReceived.id)!);
            writeToFile()
        }
    }
    
    // MARK: - FILES
    
    private func writeToFile () {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                (idTeamsArray as NSArray).write(to: fileURL, atomically: true)
                print("WRITE")
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while adding favorite team", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func readFromFile () {
        idTeamsArray = []
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                if (NSArray(contentsOf: fileURL) == nil) { return }
                idTeamsArray = NSArray(contentsOf: fileURL) as! [Int]
                print("READ")
            }
            catch {
                let alert = UIAlertController(title: "ERRO", message: "Error while reading favorite teams", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    // MARK: - NAVIGATION
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idTeamToSend = favoriteTeams[indexPath.row].id;
        performSegue(withIdentifier: "goToTeamView", sender: idTeamToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? TeamViewController;
        info?.idTeamReceived = self.idTeamToSend;
    }
    	
    // MARK: - GET TEAMS
    
    func getTeams() {
        favoriteTeams = []
        readFromFile();
        
        for item in idTeamsArray {
            guard let url = URL(string: "http://178.62.253.177/equipa/"+String(item)) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                  error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                    guard let decode = jsonResponse as? [[String: Any]] else { print("Decode Error"); return }
                    // print(decode)
                    
                    if (decode.isEmpty) { return }
                    
                    self.favoriteTeams.append(Team(
                        id: decode[0]["id"] as! Int,
                        name: decode[0]["nome"] as! String,
                        city: decode[0]["cidade"] as! String,
                        president: decode[0]["presidente"] as! String,
                        fundationYear: decode[0]["ano_fundacao"] as! Int,
                        equipmentBrand: decode[0]["marca_equipamento"] as! String,
                        association: decode[0]["divisao_nome"] as! String))
                    
                    DispatchQueue.main.async{
                        self.favTeams.reloadData()
                    }
                    print("Decode Done");
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    }

}
