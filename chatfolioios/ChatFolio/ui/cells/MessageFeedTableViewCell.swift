//
//  MessageFeedTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MessageFeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var messageFeedCellImage: UIImageView!
    
    @IBOutlet weak var messageFeedCellTitle: UILabel!
    
    @IBOutlet weak var messageFeedCellDetails: UILabel!
    
    
    @IBOutlet weak var messageFeedCellDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
