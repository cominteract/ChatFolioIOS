//
//  ChatFolioGalleryAdapter.swift
//  ChatFolio
//
//  Created by Admin on 4/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChatFolioGallerydapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataInterface : DataInterface! = nil
    var adapterInterface : AdapterInteractionInterface! = nil
    var isPhoto : Bool = false
    var user : User! = nil
    override init() {
        super.init()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(!isPhoto)
        {
            dataInterface.onSelectedAlbum(album: dataInterface.onAlbumsRetrieved()[indexPath.row])
            adapterInterface.onClickImage(adapterType: AdapterType.AdapterGallery)
        }
        else
        {
            dataInterface.onSelectedCommentTypeId(idtype: IdType.PhotoId)
            dataInterface.onSelectedPhoto(photo: dataInterface.onPhotosRetrieved()[indexPath.row])
            adapterInterface.onClickImage(adapterType: AdapterType.AdapterPhoto)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func setPhotoType(isPhoto_ : Bool)
    {
        isPhoto = isPhoto_
    }
    

    func initializeData(dataInterface_ : DataInterface, adapterInterface_ : AdapterInteractionInterface)
    {
        dataInterface = dataInterface_
        adapterInterface = adapterInterface_
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!isPhoto)
        {
            return dataInterface.onAlbumsRetrieved().count
        }
        return dataInterface.onPhotosRetrieved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GalleryTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell") as? GalleryTableViewCell)!
        cell.galleryCellImage.sd_setImage(with: URL(string:dataInterface.onPhotosRetrieved()[indexPath.row].imageUrl), placeholderImage: UIImage(named: "cake"))
        if(isPhoto)
        {
            cell.galleryCellCaption.text = dataInterface.onPhotosRetrieved()[indexPath.row].caption
        }
        else
        {
            cell.galleryCellCaption.text = dataInterface.onAlbumsRetrieved()[indexPath.row].albumId
        }
        
        return cell
    }
    
}
