//
//  Album.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class Album: NSObject {
    var albumId : String! = nil
    var comments = Array<Comment>()
    var photos = Array<Photo>()
    var frontPhotoUrl : String! = nil
    var uploadDate : Date!
    var user : User! = nil
}
