//
//  Feed.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class Feed: NSObject {
    var feedId : String! = nil
    var recipient : User! = nil
    var sender : User! = nil
    var activityDetails : String! = nil
    var activityImageUrl : String = ""
    var comments = Array<Comment>()
    var activityPhotos = Array<Photo>()
    var activityType : ActivityType! = nil
    var postDate : Date!
}
