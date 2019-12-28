//
//  UserProfile.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class UserProfile: MainViewController, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBOutlet weak var userProfileBirthday: UILabel!
    
    @IBOutlet weak var userProfileAddress: UILabel!
    
    @IBOutlet weak var userProfileDescription: UILabel!
    
    
    @IBOutlet weak var userProfileStatus: UILabel!
    
    
    @IBOutlet weak var userProfileChatMessage: UITextField!
    
    @IBOutlet weak var userProfileChatMessageSend: UIButton!
    
 
    @IBAction func userProfileSendMessage(_ sender: Any) {
        dataInterface.onSentMessage(message: userProfileChatMessage.text!)
        messagesAdapter.updateMessages(dataInterface_: dataInterface)
        userProfileTable.reloadData()
        userProfileChatMessage.text = ""
        
    }
    
    
    @IBAction func userProfileMessagesShow(_ sender: Any) {
        userProfileChatMessage.isHidden = false
        userProfileChatMessageSend.isHidden = false
        setMessages()
    }
    
    
    @IBAction func userProfileGalleryShow(_ sender: Any) {
        userProfileChatMessage.isHidden = true
        userProfileChatMessageSend.isHidden = true
        setGallery()
    }
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    @IBOutlet weak var userProfileFullName: UILabel!
    
    @IBOutlet weak var userProfileAlbumSelected: UILabel!
    
    @IBOutlet weak var userProfileTable: UITableView!
    var galleryAdapter = ChatFolioGallerydapter()
    
    var messagesAdapter = ChatFolioMessagesAdapter()
    override func onClickImage(adapterType: AdapterType) {
        if(adapterType == AdapterType.AdapterGallery)
        {
            userProfileAlbumSelected.text = dataInterface.onSelectedAlbumRetrieved().albumId
            setPhoto()
        }
        if(adapterType == AdapterType.AdapterPhoto)
        {
            appTransitionInterface.didMoveToPhotoFull()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    if(dataInterface.onSelectedUserRetrieved() != nil)
    {
        let nibGallery = UINib.init(nibName: "GalleryTableViewCell", bundle: nil)
        userProfileTable.register(nibGallery, forCellReuseIdentifier: "GalleryTableViewCell")
        setGallery()
        let nibMessages = UINib.init(nibName: "MessagesTableViewCell", bundle: nil)
        userProfileTable.register(nibMessages, forCellReuseIdentifier: "MessagesTableViewCell")
        userProfileImage.sd_setImage(with: URL(string: dataInterface.onSelectedUserRetrieved().profilePicture), placeholderImage: UIImage(named: "cake"))
        userProfileStatus.text = dataInterface.onSelectedUserRetrieved().status
        userProfileAddress.text = dataInterface.onSelectedUserRetrieved().userAddress
        userProfileBirthday.text = dataInterface.toString(dateFormat: "yyyy-MMM-dd hh:mm:ss", date: dataInterface.onSelectedUserRetrieved().birthday)
        userProfileFullName.text = dataInterface.onSelectedUserRetrieved().fullName
        userProfileDescription.text = dataInterface.onSelectedUserRetrieved().userDetails
        userProfileChatMessage.isHidden = true
        userProfileChatMessageSend.isHidden = true
        userProfileChatMessage.delegate = self
    }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dataInterface.onSelectedUser(user: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setGallery()
    {
        galleryAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        galleryAdapter.isPhoto = false
        userProfileTable.delegate = galleryAdapter
        userProfileTable.dataSource = galleryAdapter
        userProfileTable.reloadData()
    }
    
    func setMessages()
    {
        messagesAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        userProfileTable.delegate = messagesAdapter
        userProfileTable.dataSource = messagesAdapter
        userProfileTable.reloadData()
    }

    
    func setPhoto()
    {
        userProfileAlbumSelected.text = dataInterface.onSelectedAlbumRetrieved().albumId
        galleryAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        galleryAdapter.isPhoto = true
        userProfileTable.delegate = galleryAdapter
        userProfileTable.dataSource = galleryAdapter
        userProfileTable.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
