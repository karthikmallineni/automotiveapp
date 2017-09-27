//
//  DashBoardTableViewCell.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/20/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit

class DashBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productMileage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
