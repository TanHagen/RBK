//
//  TableViewCell.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 18.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var publisherDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
