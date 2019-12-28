//
//  MessagesTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var messageCellImage: UIImageView!
    
    @IBOutlet weak var messageCellTitle: UILabel!
    
    @IBOutlet weak var messageCellDetails: UILabel!
    
    
    @IBOutlet weak var messageCellDate: UILabel!
    

    override func layoutSubviews() {
        layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
        
        layer.masksToBounds = false
      
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath.cgPath

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
