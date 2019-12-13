//
//  ResultTableViewCell.swift
//  Project
//
//  Created by formando on 06/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamOutlet: UIButton!
    @IBOutlet weak var homeTeamGoalsOutlet: UILabel!
    @IBOutlet weak var awayTeamGoalsOutlet: UILabel!
    @IBOutlet weak var awayTeamOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
