//
//  CommentTableViewCell.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var commentCellImage: UIImageView!
    
    @IBOutlet weak var commentCellTitle: UILabel!
    
    @IBOutlet weak var commentCellDetails: UILabel!
    
    
    @IBOutlet weak var commentCellDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
