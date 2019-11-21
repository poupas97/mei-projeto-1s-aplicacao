//
//  LeagueTableViewController.swift
//  Project
//
//  Created by formando on 21/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {

    var leagues: [League] = [League(name: "honra"), League(name: "serie a")];
    let identifier = "LeagueIdentifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! LeagueTableViewCell;
        cell.labelOutlet.text = leagues[indexPath.row].name;
        return cell;
    }
}
