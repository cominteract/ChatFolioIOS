//
//  FeedTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var feedCellImage: UIImageView!
    
    @IBOutlet weak var feedCellSubImage1: UIImageView!
    
    @IBOutlet weak var feedCellSubImage2: UIImageView!
    
    @IBOutlet weak var feedCellSubImage3: UIImageView!
    
    
    @IBOutlet weak var feedCellTitle: UILabel!
    
    
    @IBOutlet weak var feedCellDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
