//
//  MainNavigation.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MainNavigation: UINavigationController, AppTransitionInterface,DataAvailabilityInterface {
    func didMoveToChat() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let userChatMessages = storyboard.instantiateViewController(withIdentifier: "UserChatMessages")
        self.pushViewController(userChatMessages, animated: true)
    }
    
    
    func didMoveToFeedFull() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let fullScreenDialogFeed = storyboard.instantiateViewController(withIdentifier: "FullScreenFeedDialog") as? FullScreenFeedDialog
        fullScreenDialogFeed?.dataInterface = dataInterface
        fullScreenDialogFeed?.modalPresentationStyle = .overCurrentContext
        self.present(fullScreenDialogFeed!, animated: true, completion: nil)
    }
    
    func didMoveToPhotoFull() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let fullScreenDialogPhoto = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoDialog") as? FullScreenPhotoDialog
        fullScreenDialogPhoto?.dataInterface = dataInterface
        fullScreenDialogPhoto?.modalPresentationStyle = .overCurrentContext
        self.present(fullScreenDialogPhoto!, animated: true, completion: nil)
    }
    
    func didMoveToProfile() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let userProfile = storyboard.instantiateViewController(withIdentifier: "UserProfile")
        self.pushViewController(userProfile, animated: true)
    }
    
    func onMockDataRetrieved() {
        dataFragmentInterface.onMockDataRetrieved()
    }
    
    func onInterfaceLoaded() {
        isLoaded = true
        folioManager.initalizeManager(dataAvailabilityInterface: self)
    }

    
    var isLoaded = false
    var dataFragmentInterface: DataAvailabilityInterface! = nil
    var folioManager = ChatFolioManager()
    var dataInterface : DataInterface! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataInterface = folioManager

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
