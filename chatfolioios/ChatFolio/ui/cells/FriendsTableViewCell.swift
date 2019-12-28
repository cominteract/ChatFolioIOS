//
//  FriendsTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var friendsCellImage: UIImageView!
    
    @IBOutlet weak var friendsCellTitle: UILabel!
    
    
    @IBOutlet weak var friendsCellDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
