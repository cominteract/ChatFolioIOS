//
//  UserChatMessages.swift
//  ChatFolio
//
//  Created by Admin on 4/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class UserChatMessages: MainViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    

    @IBOutlet weak var userChatMessagesTable: UITableView!
    
    
    @IBOutlet weak var userChatMessageText: UITextField!
    
    
  
    
    @IBAction func onChatMessageSent(_ sender: Any) {
        dataInterface.onSentMessage(message: userChatMessageText.text!)
        messagesAdapter.updateMessages(dataInterface_: dataInterface)
        userChatMessagesTable.reloadData()
        userChatMessageText.text = ""
        
    }
    
    var messagesAdapter = ChatFolioMessagesAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataInterface.onMessagesRetrieved() != nil)
        {
            let nibMessages = UINib.init(nibName: "MessagesTableViewCell", bundle: nil)
            userChatMessagesTable.register(nibMessages, forCellReuseIdentifier: "MessagesTableViewCell")
            userChatMessageText.delegate = self
            setMessages()
        }
        // Do any additional setup after loading the view.
    }
    
    func setMessages()
    {
        messagesAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        userChatMessagesTable.delegate = messagesAdapter
        userChatMessagesTable.dataSource = messagesAdapter
        userChatMessagesTable.reloadData()
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
