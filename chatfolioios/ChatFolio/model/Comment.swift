//
//  Comment.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class Comment: NSObject {
    var commentId : String! = nil
    var comment : String! = nil
    var replyTo : Comment! = nil
    var user : User! = nil
    var commentDate : Date!
    
}
