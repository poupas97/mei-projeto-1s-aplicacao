//
//  ClassificationTableViewCell.swift
//  Project
//
//  Created by formando on 29/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class ClassificationTableViewCell: UITableViewCell {

    @IBOutlet weak var classificationOutlet: UILabel!
    @IBOutlet weak var pointsOutlet: UILabel!
    @IBOutlet weak var teamOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
