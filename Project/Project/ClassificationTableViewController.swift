//
//  ClassificationTableViewController.swift
//  Project
//
//  Created by formando on 27/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//


// https://www.youtube.com/watch?v=TCj3qe5zKlc

import UIKit

class ClassificationTableViewController: UITableViewController {

    // MARK: - VAR
    
    var idLeagueReceived: Int = 0;
    var idTeamToSend = 0;
    var position: Int = 0;
    var idWeekMatch: Int = 0;
    
    @IBOutlet var classifications: UITableView!
    
    var arrayClassifications: [Classification] = [];
    let identifier = "ClassificationIdentifier";
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classifications.dataSource = self
        self.classifications.delegate = self
        
        getClassifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    // MARK: - TABLE VIEW DATA SOURCE

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayClassifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ClassificationTableViewCell;
        position = position + 1;
        cell.classificationOutlet.text = String(position)+"º";
        cell.teamOutlet.text = arrayClassifications[indexPath.row].nameTeam;
        cell.pointsOutlet.text = String(arrayClassifications[indexPath.row].points);
        cell.weekMatchOutlet.text = String(arrayClassifications[indexPath.row].games);
        return cell;
    }

    // MARK: - NAVIGATION

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idTeamToSend = arrayClassifications[indexPath.row].idTeam;
        performSegue(withIdentifier: "goToTeamView", sender: idTeamToSend);
    }
    
    @IBAction func clickButtonResults(_ sender: Any) {
        performSegue(withIdentifier: "goToResults", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let info = segue.destination as? TeamViewController {
            info.idTeamReceived = self.idTeamToSend;
        }
        
        if let info = segue.destination as? ResultTableViewController {
            info.idWeekMatchReceived = self.idWeekMatch
        }
    }
    
    // MARK: - GET CLASSIFICATIONS
    
    func getClassifications() {
        guard let url = URL(string: "http://178.62.253.177/classificacoes") else { return }
        
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
                
                for item in decode {
                    self.arrayClassifications.append(Classification(
                        idTeam: item["equipa_id"] as! Int,
                        nameTeam: item["nome"] as! String,
                        games: item["jogos"] as! Int,
                        points: item["pontos"] as! Int,
                        victories: item["vitorias"] as! Int,
                        defeats: item["derrotas"] as! Int,
                        draws: item["empates"] as! Int,
                        goalsScored: item["golos_marcardos"] as! Int,
                        goalsConceded: item["golos_sofridos"] as! Int,
                        differenceGoals: item["diferença_golos"] as! Int))
                    self.idWeekMatch = item["jornada_id"] as! Int;
                }
                
                DispatchQueue.main.async{
                    self.classifications.reloadData()
                }
                print("Decode Done");
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
