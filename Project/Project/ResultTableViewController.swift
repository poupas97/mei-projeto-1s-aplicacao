//
//  ResultTableViewController.swift
//  Project
//
//  Created by formando on 06/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//
 
import UIKit

class ResultTableViewController: UITableViewController {
    
    // MARK: - VAR
    
    @IBOutlet var tableViewResults: UITableView!
    
    var idWeekMatch = 0
    var weekMatchReceived = 0
    
    var results: [Result] = [];
    let identifier = "ResultIdentifier";

    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewResults.dataSource = self
        self.tableViewResults.delegate = self
        
        getResults(weekMatch: weekMatchReceived)
        print(weekMatchReceived)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewResults.reloadData();
    }

    // MARK: - TABLE VIEW DATA SOURCE
    
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
    
    // MARK: - NAVIGATION
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToSend = leagues[indexPath.row].id;
        performSegue(withIdentifier: "goToClassification", sender: idToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? ClassificationTableViewController;
        info?.idLeagueReceived = self.idToSend;
    }*/
    
    // MARK: - BUTTONS
    
    @IBAction func leftButton(_ sender: Any) {
        if (results[0].weekMatch - 1 <= 0) { return }
        
        getResults(weekMatch: results[0].weekMatch - 1)
    }
    
    @IBAction func rightButton(_ sender: Any) {
        if (results[0].weekMatch + 1 > self.weekMatchReceived) { return }
        
        getResults(weekMatch: results[0].weekMatch + 1)
    }
    
    // MARK: - GET RESULTS
    
    func getResults(weekMatch: Int) {
        guard let url = URL(string: "http://178.62.253.177/jornadas") else { return }
        
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
                
                for item in decode {
                    self.results.append(Result(
                        id: item["id"] as! Int,	
                        idHomeTeam: item["id_equipa_casa"] as! Int,
                        nameHomeTeam: "",
                        goalsHomeTeam: Int((item["resultado_equipa_casa"] as! NSString).floatValue),
                        idAwayTeam: item["id_equipa_fora"] as! Int,
                        nameAwayTeam: "",
                        goalsAwayTeam: Int((item["resultado_equipa_fora"] as! NSString).floatValue),
                        weekMatch: 0))
                }
                
                DispatchQueue.main.async{
                    self.tableViewResults.reloadData()
                }
                print("Decode Done");
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
