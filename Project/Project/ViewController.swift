//
//  ViewController.swift
//  Project
//
//  Created by formando on 14/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func footballAction(_ sender: Any) {
        performSegue(withIdentifier: "segueFootball", sender: self);
    }
    
    @IBAction func ftusalAction(_ sender: Any) {
        performSegue(withIdentifier: "segueFutsal", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFootball" {
            if let destination = segue.destination as? LeagueTableViewController {
                destination.idReceived = 1
            }
        }
        
        if segue.identifier == "segueFutsal" {
            if let destination = segue.destination as? LeagueTableViewController {
                destination.idReceived = 2
            }
        }
    }
}

