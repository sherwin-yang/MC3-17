//
//  ResultOverviewTableViewCell.swift
//  MC3-17
//
//  Created by Sherwin Yang on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ResultOverviewTableViewCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var playImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
