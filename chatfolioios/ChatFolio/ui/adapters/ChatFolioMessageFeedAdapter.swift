//
//  ChatFolioMessageFeedAdapter.swift
//  ChatFolio
//
//  Created by Admin on 4/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChatFolioMessageFeedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataInterface : DataInterface! = nil
    var adapterInterface : AdapterInteractionInterface! = nil
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataInterface.onSelectedUser(user:dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.sender )
        adapterInterface.onClickImage(adapterType: AdapterType.AdapterMessage)
    }
    
    
    func initializeData(dataInterface_ : DataInterface, adapterInterface_ : AdapterInteractionInterface)
    {
        dataInterface = dataInterface_
        adapterInterface = adapterInterface_
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInterface.onMessagesFeedRetrieved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessageFeedTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "MessageFeedTableViewCell") as? MessageFeedTableViewCell)!
        cell.messageFeedCellImage.sd_setImage(with: URL(string: dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.sender.profilePicture), placeholderImage: UIImage(named: "cake"))
        if(dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.sender != dataInterface.onCurrentUserRetrieved())
        {
            cell.messageFeedCellTitle.text = dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.sender.fullName
        }
        else
        {
            cell.messageFeedCellTitle.text = dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.recipient.fullName
        }
        cell.messageFeedCellDetails.text = dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.chatMessage
        
        cell.messageFeedCellDate.text = dataInterface.toString(dateFormat: "yyyy-MMM-dd hh:mm:ss", date: dataInterface.onMessagesFeedRetrieved()[indexPath.row].lastMessage.messageDate)
        
        return cell
    }
    
}
