//
//  ChatFolioMessagesAdapter.swift
//  ChatFolio
//
//  Created by Admin on 4/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChatFolioMessagesAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    var dataInterface : DataInterface! = nil
    var adapterInterface : AdapterInteractionInterface! = nil
    var messages : Array<Message>! = nil
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func initializeData(dataInterface_ : DataInterface, adapterInterface_ : AdapterInteractionInterface)
    {
     
        adapterInterface = adapterInterface_
        updateMessages(dataInterface_: dataInterface_)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func updateMessages(dataInterface_ : DataInterface)
    {
        dataInterface = dataInterface_
        messages = dataInterface.onMessagesRetrievedFrom(user: dataInterface.onSelectedUserRetrieved())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessagesTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell") as? MessagesTableViewCell)!
        cell.messageCellImage.sd_setImage(with: URL(string: messages[indexPath.row].sender.profilePicture), placeholderImage: UIImage(named: "cake"))
        
        cell.messageCellTitle.text = messages[indexPath.row].sender.fullName
    if(messages[indexPath.row].sender.isEqual(dataInterface.onCurrentUserRetrieved()))
        {
            cell.messageCellDetails.backgroundColor = UIColor.blue
        }
        else
        {
            cell.messageCellDetails.backgroundColor = UIColor.red
        }
        
//        if(dataInterface.onMessagesRetrievedFrom(user: dataInterface.onSelectedUserRetrieved())[indexPath.row].sender != dataInterface.onCurrentUserRetrieved())
//        {
//            cell.messageCellTitle.text = dataInterface.onMessagesRetrievedFrom(user: dataInterface.onSelectedUserRetrieved())[indexPath.row].sender.fullName
//        }
//        else
//        {
//            cell.messageCellTitle.text = dataInterface.onMessagesRetrievedFrom(user: dataInterface.onSelectedUserRetrieved())[indexPath.row].recipient.fullName
//        }
        cell.messageCellDetails.text = messages[indexPath.row].chatMessage
        cell.messageCellDate.text = dataInterface.toString(dateFormat: "yyyy-MMM-dd hh:mm:ss", date: messages[indexPath.row].messageDate)
        return cell
    }
}
