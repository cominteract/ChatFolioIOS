//
//  ChatFolioUsersAdapter.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChatFolioUsersAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataInterface : DataInterface! = nil
    var adapterInterface : AdapterInteractionInterface! = nil
    override init() {
        super.init()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataInterface.onSelectedCurrentUser(user: dataInterface.onUsersRetrieved()[indexPath.row])
        adapterInterface.onClickTitle(adapterType: AdapterType.AdapterLogin)
    }
    
    func initializeData(dataInterface_ : DataInterface, adapterInterface_ : AdapterInteractionInterface)
    {
        dataInterface = dataInterface_
        adapterInterface = adapterInterface_
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInterface.onUsersRetrieved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell)!
        cell.userCellImage.sd_setImage(with: URL(string: dataInterface.onUsersRetrieved()[indexPath.row].profilePicture), placeholderImage: UIImage(named: "cake"))
        cell.userCellTitle.text = dataInterface.onUsersRetrieved()[indexPath.row].fullName
        cell.userCellDetails.text = dataInterface.onUsersRetrieved()[indexPath.row].userName
        return cell
    }
}
