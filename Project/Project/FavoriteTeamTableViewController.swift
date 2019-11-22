//
//  FavoriteTeamTableViewController.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

// https://www.youtube.com/watch?v=MOoLfHTTNDs

import UIKit

class FavoriteTeamTableViewController: UITableViewController {

    var favoriteTeams: [Team] = [Team(name: "alq"), Team(name: "pdm")];
    let identifier = "FavoriteTeamIdentifier";
    
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
        return favoriteTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FavoriteTeamTableViewCell;
        cell.labelOutlet.text = favoriteTeams[indexPath.row].name;
        
        /* let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("imageTapped:")));
        cell.imageOutlet.addGestureRecognizer(tapGesture)
        cell.imageOutlet.isUserInteractionEnabled = true */
        
        return cell;
    }

    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController

        }
    }
    
    
    //https://stackoverflow.com/questions/26207846/pass-data-through-segue
    
    func gotToScreen(){
        performSegue(withIdentifier: "Ecra")
        let tvc = TeamViewController()
        tvc.
    }

}
