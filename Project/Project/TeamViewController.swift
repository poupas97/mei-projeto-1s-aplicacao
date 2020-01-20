//
//  TeamViewController.swift
//  Project
//
//  Created by formando on 22/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    
    // MARK: - VAR
    
    @IBOutlet var teamView: UIView!
    @IBOutlet weak var teamNameOutlet: UILabel!
    @IBOutlet weak var pointsOutlet: UILabel!
    @IBOutlet weak var matchWeekOutlet: UILabel!
    @IBOutlet weak var victoriesOutlet: UILabel!
    @IBOutlet weak var drawerOutlet: UILabel!
    @IBOutlet weak var defeatsOutlet: UILabel!
    @IBOutlet weak var goalsScored: UILabel!
    @IBOutlet weak var goalsConcededOutlet: UILabel!
    @IBOutlet weak var goalsDeferenceOutlet: UILabel!
    @IBOutlet weak var foundedOutlet: UILabel!
    @IBOutlet weak var equipmentBrandOutlet: UILabel!
    @IBOutlet weak var associactionOutlet: UILabel!
    @IBOutlet weak var localOutlet: UILabel!
    @IBOutlet weak var presidentOutlet: UILabel!
    
    var team: Team = Team()
    var idTeamReceived: Int = 0;
    var isFavotiteTeam: Bool = false
    
    // MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        getTeam(idTeam: idTeamReceived)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    // MARK: - ACTIONS
    
    @IBAction func setTeamFavorite(_ sender: Any) {
        
        isFavotiteTeam ? FavoriteTeamTableViewController().removeFavoritTeam(teamReceived: team) : FavoriteTeamTableViewController().addFavoritTeam(teamReceived: team);
        
        isFavotiteTeam = !isFavotiteTeam
        getIconFavotire();
    }
    
    private func getIconFavotire() {
        isFavotiteTeam = FavoriteTeamTableViewController().existInTeams(team: team)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: isFavotiteTeam ? "star.fill" : "star"), style: .plain, target: self, action: Selector("setTeamFavorite:"))
    }
    
    // MARK: - GET TEAM
    
    func getTeam(idTeam: Int) {
        guard let url = URL(string: "http://178.62.253.177/equipa/"+String(idTeam)) else {return}
        
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
                // print(decode[0]["id"]!)
                self.team = Team(
                    id: decode[0]["id"] as! Int,
                    name: decode[0]["nome"] as! String,
                    city: decode[0]["cidade"] as! String,
                    president: decode[0]["presidente"] as! String,
                    fundationYear: decode[0]["ano_fundacao"] as! Int,
                    equipmentBrand: decode[0]["marca_equipamento"] as! String,
                    idAssociation: 0,
                    points: decode[0]["pontos"] as! Int,
                    matchWeek: decode[0]["jogos"] as! Int,
                    victories: decode[0]["vitorias"] as! Int,
                    drawers: decode[0]["empates"] as! Int,
                    defeats: decode[0]["derrotas"] as! Int,
                    goalsScored: decode[0]["golos_marcardos"] as! Int,
                    goalsConceded: decode[0]["golos_sofridos"] as! Int,
                    goalsDeference: decode[0]["diferença_golos"] as! Int)
                
                DispatchQueue.main.async{
                    self.teamNameOutlet.text = self.team.name;
                    self.pointsOutlet.text = String(self.team.points)
                    self.matchWeekOutlet.text = String(self.team.matchWeek)
                    self.victoriesOutlet.text = String(self.team.victories)
                    self.drawerOutlet.text = String(self.team.drawers)
                    self.defeatsOutlet.text = String(self.team.defeats)
                    self.goalsScored.text = String(self.team.goalsScored)
                    self.goalsConcededOutlet.text = String(self.team.goalsConceded)
                    self.goalsDeferenceOutlet.text = String(self.team.goalsDeference)
                    self.foundedOutlet.text = String(self.team.fundationYear)
                    self.equipmentBrandOutlet.text = self.team.equipmentBrand
                    self.associactionOutlet.text = String(self.team.idAssociation)
                    self.localOutlet.text = self.team.city
                    self.presidentOutlet.text = self.team.president
                    
                    self.getIconFavotire();
                    
                    self.teamView.reloadInputViews()
                }
                print("Decode Done");
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
