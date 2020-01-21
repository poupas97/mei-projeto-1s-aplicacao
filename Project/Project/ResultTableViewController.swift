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
    @IBOutlet weak var weekMatchOutlet: UILabel!
    
    var weekMatch = 0
    var idWeekMatchReceived = 0
    
    var results: [Result] = [];
    let identifier = "ResultIdentifier";

    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewResults.dataSource = self
        self.tableViewResults.delegate = self
        
        getResults(idWeekMatch: idWeekMatchReceived)
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
    
    // MARK: - BUTTONS
    
    @IBAction func leftButton(_ sender: Any) {
        if (results.isEmpty || results[0].weekMatch - 1 <= 0) { return }
        
        getResults(idWeekMatch: results[0].weekMatch - 1)
    }
    
    @IBAction func rightButton(_ sender: Any) {
        if (results.isEmpty || results[0].weekMatch + 1 > self.weekMatch) { return }
        
        getResults(idWeekMatch: results[0].weekMatch + 1)
    }
    
    // MARK: - GET RESULTS
    
    func getResults(idWeekMatch: Int) {
        self.results = []
        guard let url = URL(string: "http://178.62.253.177/jornadas/"+String(idWeekMatch)) else { return }
        
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
                    self.results.append(Result(
                        id: item["id"] as! Int,	
                        idHomeTeam: item["id_equipa_casa"] as! Int,
                        nameHomeTeam: item["nome_equipa_casa"] as! String,
                        goalsHomeTeam: Int((item["resultado_equipa_casa"] as! NSString).floatValue),
                        idAwayTeam: item["id_equipa_fora"] as! Int,
                        nameAwayTeam: item["nome_equipa_fora"] as! String,
                        goalsAwayTeam: Int((item["resultado_equipa_fora"] as! NSString).floatValue),
                        weekMatch: item["numero_jornada"] as! Int))
                }
                
                DispatchQueue.main.async{
                    self.weekMatch = decode[0]["numero_jornada"] as! Int
                    self.weekMatchOutlet.text = "WeekMatch " + String(self.weekMatch)
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
