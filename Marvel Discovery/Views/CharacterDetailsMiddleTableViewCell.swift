//
//  CharacterDetailsMiddleTableViewCell.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/7/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit

class CharacterDetailsMiddleTableViewCell: UITableViewCell {

    @IBOutlet weak var middleSectionTitle: UILabel!
    @IBOutlet weak var middleSectionCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class MiddleSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var middleSectionImageView: UIImageView!
    @IBOutlet weak var middleSectionTitleLbl: UILabel!
    
}
