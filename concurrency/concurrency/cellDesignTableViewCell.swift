//
//  cellDesignTableViewCell.swift
//  concurrency
//
//  Created by albert coelho oliveira on 9/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class cellDesignTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var population: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
