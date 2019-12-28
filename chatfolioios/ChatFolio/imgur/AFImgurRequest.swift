//
//  AFImgurRequest.swift
//  ChatFolio
//
//  Created by Admin on 5/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class AFImgurRequest: NSObject {

    func PostData(){
        
      
    }
    
    func startImgurRequest(dataInterface : DataInterface,dataAvailabilityInterface : DataAvailabilityInterface)
    {
        //https://api.imgur.com/3/album/04Bh0NF/images
      //Client-ID 93da96f0c1a3b48
        

        
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 93da96f0c1a3b48",
        ]
        
        Alamofire.request("https://api.imgur.com/3/album/04Bh0NF/images", headers: headers).responseJSON { response in
            //debugPrint(response.result)
            debugPrint(response.result.value!)
       
            let dict = response.result.value! as? Dictionary<String,Any>
            if(dict?.keys.contains("data"))!
            {
                
                if let dataArray = dict?["data"] as? Array<Dictionary<String, Any>>
                {
                    var arrayImage = Array<ImgurImage>()
                    for data in dataArray
                    {
                        let imgurImage = ImgurImage()
                        imgurImage.link = data["link"] as! String
                        arrayImage.append(imgurImage)
                        //imgurImage.bandwidth = data.index(forKey: "bandwidth")
                        //imgurImage.size = data.index(forKey: "bandwidth")
                        
                    }
                    dataInterface.onImgurRetrieved(imgurPhotos_: arrayImage, dataAvailabilityInterface: dataAvailabilityInterface)
                }
            }
//            let jsonDecoder = JSONDecoder()
//            let dataImgur = try! jsonDecoder.decode(DataImgur.self, from: "\(result)".data(using: .utf8)!)
            
            
            
        }
    }
}
