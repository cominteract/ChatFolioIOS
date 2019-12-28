//
//  Message.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class Message: NSObject {
    var messageId : String! = nil
    var sender : User! = nil
    var recipient : User! = nil
    var chatMessage : String! = nil
    var messageDate : Date!
    
}
