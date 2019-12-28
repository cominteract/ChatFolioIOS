//
//  ChatFolioFeedAdapter.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SDWebImage
class ChatFolioFeedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataInterface : DataInterface! = nil
     var adapterInterface : AdapterInteractionInterface! = nil
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataInterface.onSelectedCommentTypeId(idtype: IdType.FeedId)
        dataInterface.onSelectedFeed(feed: dataInterface.onFeedRetrieved().sorted(by: { $0.postDate > $1.postDate })[indexPath.row])
        adapterInterface.onClickImage(adapterType: AdapterType.AdapterFeed)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func initializeData(dataInterface_ : DataInterface, adapterInterface_ : AdapterInteractionInterface)
    {
        dataInterface = dataInterface_
        
        adapterInterface = adapterInterface_
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInterface.onFeedRetrieved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FeedTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell)!
        cell.feedCellImage.sd_setImage(with: URL(string: dataInterface.onFeedRetrieved().sorted(by: { $0.postDate > $1.postDate })[indexPath.row].activityImageUrl), placeholderImage: UIImage(named: "cake"))
        cell.feedCellTitle.text = dataInterface.onFeedRetrieved().sorted(by: { $0.postDate > $1.postDate })[indexPath.row].recipient.fullName
        cell.feedCellDetails.text = dataInterface.onFeedRetrieved().sorted(by: { $0.postDate > $1.postDate })[indexPath.row].activityDetails
        return cell
    }

}
