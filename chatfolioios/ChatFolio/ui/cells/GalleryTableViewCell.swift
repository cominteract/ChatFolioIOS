//
//  GalleryTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var galleryCellImage: UIImageView!
    
    @IBOutlet weak var galleryCellCaption: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
