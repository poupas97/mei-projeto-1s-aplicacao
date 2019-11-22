//
//  TeamViewController.swift
//  Project
//
//  Created by formando on 21/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    
    var team: Team = Team(name: "alqueidao");
    var teste: String

    override func viewDidLoad() {
        super.viewDidLoad();

        print(team.name);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    
}
