//
//  Home.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Home: MainViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBOutlet weak var homePostMessage: UITextField!
    @IBOutlet weak var homeLogged: UIButton!
    
    @IBOutlet weak var homeSendButton: UIButton!
    @IBOutlet weak var homeLayoutView: UIStackView!
    
    var timelineAdapter = ChatFolioFeedAdapter()
    var usersAdapter = ChatFolioUsersAdapter()
    var messageFeedAdapter = ChatFolioMessageFeedAdapter()
    var galleryAdapter = ChatFolioGallerydapter()
    var friendsAdapter = ChatFolioFriendsAdapter()
    
    
    override func onMockDataRetrieved() {
        toggleLogin(logged: false)
    }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
         toggleLogin(logged: false)
    }
    
    
    @IBOutlet weak var homeLoggedInUser: UIButton!
    
    @IBAction func onHomeTimelineClicked(_ sender: Any) {
        setTimeline()
    }
    
    
    @IBAction func onHomeFriendsClicked(_ sender: Any) {
        setFriends()
    }
    
    
    @IBAction func onHomePhotosClicked(_ sender: Any) {
        setGallery()
    }
    
    @IBAction func onHomeMessagesClicked(_ sender: Any) {
        setMessages()
    }
    
    
    @IBAction func onHomeUserClicked(_ sender: Any) {
        print("Going to profile")
        dataInterface.onSelectedUser(user: dataInterface.onCurrentUserRetrieved())
        appTransitionInterface.didMoveToProfile()
    }
    
    
    @IBAction func onSendMessage(_ sender: Any) {
        dataInterface.onPostFeed(feed: homePostMessage.text!, photoFeed: Array<Photo>())
        timelineAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        homeTable.reloadData()
    }
    
    @IBOutlet weak var homeTable: UITableView!
    
    
    override func onClickTitle(adapterType: AdapterType) {
        if(adapterType == AdapterType.AdapterLogin)
        {
             toggleLogin(logged: true)
        }
        if(adapterType == AdapterType.AdapterFriends)
        {
            dataInterface.onSelectedUser(user: dataInterface.onSelectedUserRetrieved())
            appTransitionInterface.didMoveToProfile()
        }
    }
    
    override func onClickImage(adapterType: AdapterType) {
        if(adapterType == AdapterType.AdapterGallery)
        {
            setPhoto()
        }
        if(adapterType == AdapterType.AdapterPhoto)
        {
            appTransitionInterface.didMoveToPhotoFull()
        }
        if(adapterType == AdapterType.AdapterFeed)
        {
            appTransitionInterface.didMoveToFeedFull()
        }
        if(adapterType == AdapterType.AdapterMessage)
        {
            appTransitionInterface.didMoveToChat()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibUsers = UINib.init(nibName: "UserTableViewCell", bundle: nil)
        homeTable.register(nibUsers, forCellReuseIdentifier: "UserTableViewCell")
        let nibFeed = UINib.init(nibName: "FeedTableViewCell", bundle: nil)
        homeTable.register(nibFeed, forCellReuseIdentifier: "FeedTableViewCell")
    
    
        let nibFriends = UINib.init(nibName: "FriendsTableViewCell", bundle: nil)
        homeTable.register(nibFriends, forCellReuseIdentifier: "FriendsTableViewCell")
        let nibGallery = UINib.init(nibName: "GalleryTableViewCell", bundle: nil)
        homeTable.register(nibGallery, forCellReuseIdentifier: "GalleryTableViewCell")
        let nibMessageFeed = UINib.init(nibName: "MessageFeedTableViewCell", bundle: nil)
        homeTable.register(nibMessageFeed, forCellReuseIdentifier: "MessageFeedTableViewCell")
        
        
        homePostMessage.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleLogin(logged : Bool)
    {
        if(logged)
        {
            homeLogged.setTitle("Logout", for: UIControlState.normal)
            homeLoggedInUser.setTitle("Logged in as" + dataInterface.onCurrentUserRetrieved().fullName, for: UIControlState.normal)
            homeLoggedInUser.isHidden = false
            homeLayoutView.isHidden = false
            homePostMessage.isHidden = false
            homeSendButton.isHidden = false
            setTimeline()
            
        }
        else
        {
            homeLogged.setTitle("Login as:", for: UIControlState.normal)
            homeLoggedInUser.setTitle("Logged in as" , for: UIControlState.normal)
            homeLoggedInUser.isHidden = true
            homeLayoutView.isHidden = true
            homePostMessage.isHidden = true
            homeSendButton.isHidden = true
            setUsers()
        }
    }
    
    
    func setTimeline()
    {
        timelineAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        homeTable.delegate = timelineAdapter
        homeTable.dataSource = timelineAdapter
        homeTable.reloadData()
    }
    
    func setFriends()
    {
        
        friendsAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        homeTable.delegate = friendsAdapter
        homeTable.dataSource = friendsAdapter
        homeTable.reloadData()
    }
    
    func setGallery()
    {
        galleryAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        galleryAdapter.isPhoto = false
        homeTable.delegate = galleryAdapter
        homeTable.dataSource = galleryAdapter
        homeTable.reloadData()
    }
    
    
    
    func setPhoto()
    {
        galleryAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        galleryAdapter.isPhoto = true
        homeTable.delegate = galleryAdapter
        homeTable.dataSource = galleryAdapter
        homeTable.reloadData()
    }
    
    func setMessages()
    {
        messageFeedAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        homeTable.delegate = messageFeedAdapter
        homeTable.dataSource = messageFeedAdapter
        homeTable.reloadData()
    }
    
    func setUsers()
    {
        usersAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        homeTable.delegate = usersAdapter
        homeTable.dataSource = usersAdapter
        homeTable.reloadData()
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
