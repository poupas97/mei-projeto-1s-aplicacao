//
//  FavoriteTeamTableViewCell.swift
//  Project
//
//  Created by formando on 20/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit

class FavoriteTeamTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
