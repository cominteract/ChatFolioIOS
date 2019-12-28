//
//  ImgurResponse.swift
//  ChatFolio
//
//  Created by Admin on 5/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

struct ImgurResponse: Codable {
    var SUCCESS : SuccessImgur
}

struct SuccessImgur: Codable {
    var data: Array<ImgurImages>
}


struct DataImgur: Codable {
    //var data: Array<ImgurImages>
    var status : Int
    var success : Int
}

struct ImgurImages: Codable{
    var bandwidth : Int64
    var datetime : Int64
    var height : Int
    var width : Int
    var link : String
    var size : Int
    var views : Int

}


public class ImgurImage: NSObject{
    var bandwidth : Int64 = 0
    var datetime : Int64 = 0
    var height : Int = 0
    var width : Int = 0
    var link : String! = nil
    var size : Int = 0
    var views : Int = 0
    override init() {
        super.init()
    }
}

