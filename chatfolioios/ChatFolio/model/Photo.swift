//
//  Photo.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public class Photo: NSObject {
    var photoId : String! = nil
    var comments = Array<Comment>()
    var albumId : String! = nil
    var imageUrl : String! = nil
    var caption : String! = nil
    var uploadDate : Date!
    var user : User! = nil
}
