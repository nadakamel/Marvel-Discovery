//
//  CharacterDetailsTopTableViewCell.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/7/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit

class CharacterDetailsTopTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLbl: UILabel!
    @IBOutlet weak var characterDescriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
