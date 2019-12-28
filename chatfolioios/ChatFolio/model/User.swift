//
//  User.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class User: NSObject {
    var userId : String! = nil
    var userName : String! = nil
    var password : String! = nil
    var fullName : String! = nil
    var profilePicture : String! = nil
    var userAddress : String! = nil
    var userDetails : String! = nil
    var status : String! = nil
    var birthday : Date!
    var lastMessage : Message! = nil
    var friends = Array<User>()
    var messages = Array<Message>()
    var messageFeed = Array<MessageFeed>()
    var messageFeedUsers = Array<User>()
    var albums = Array<Album>()
    var photos = Array<Photo>()
    var activities = Array<Feed>()
    
    
}
