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
    
    var team: Team = Team(id:1, name: "Alqueidao da Serra")
    var idTeam: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameOutlet.text = String(idTeam);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

}
