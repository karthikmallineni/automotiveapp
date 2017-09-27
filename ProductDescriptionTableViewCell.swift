//
//  ProductDescriptionTableViewCell.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/22/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
