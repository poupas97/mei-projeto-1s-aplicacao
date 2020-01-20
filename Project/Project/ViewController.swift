//
//  ViewController.swift
//  Project
//
//  Created by formando on 14/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - ACTIONS
    
    @IBAction func footballAction(_ sender: Any) {
        performSegue(withIdentifier: "segueFootball", sender: self);
    }
    
    @IBAction func ftusalAction(_ sender: Any) {
        performSegue(withIdentifier: "segueFutsal", sender: self);
    }
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LeagueTableViewController {
            destination.modalityReceived = segue.identifier == "segueFootball" ? "futebol" : "futsal"
        }
    }
}

