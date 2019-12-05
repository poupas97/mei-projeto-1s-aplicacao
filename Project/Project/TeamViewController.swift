//
//  TeamViewController.swift
//  Project
//
//  Created by formando on 22/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    
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
    @IBOutlet weak var adressOutlet: UILabel!
    @IBOutlet weak var localOutlet: UILabel!
    @IBOutlet weak var presidentOutlet: UILabel!
    
    var team: Team = Team(id: 2, name: "Alqueidao da Serraaaaaa")
    var idTeamReceived: Int = 0;
    var isFavotiteTeam: Bool = false
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameOutlet.text = "qualquer equipa serve";
        pointsOutlet.text = String(10)
        matchWeekOutlet.text = String(10)
        victoriesOutlet.text = String(15)
        drawerOutlet.text = String(5)
        defeatsOutlet.text = String(1)
        goalsScored.text = String(0)
        goalsConcededOutlet.text = String(5)
        goalsDeferenceOutlet.text = String(5)
        foundedOutlet.text = "1989/9/9"
        equipmentBrandOutlet.text = "Macron"
        associactionOutlet.text = "AF Leiria"
        adressOutlet.text = "Nao seo"
        localOutlet.text = "Nao sei"
        presidentOutlet.text = "qq coisa serve"
        
        getIconFavotire();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    // MARK: - Actions
    
    @IBAction func setTeamFavorite(_ sender: Any) {
        isFavotiteTeam ? FavoriteTeamTableViewController().removeFavoritTeam(teamReceived: team) : FavoriteTeamTableViewController().addFavoritTeam(teamReceived: team);
        
        isFavotiteTeam = !isFavotiteTeam
        getIconFavotire();
    }
    
    private func getIconFavotire() {
        //TODO: check if tema is favorite
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: isFavotiteTeam ? "star.fill" : "star"), style: .plain, target: self, action: Selector("setTeamFavorite:"))
    }
    
}
