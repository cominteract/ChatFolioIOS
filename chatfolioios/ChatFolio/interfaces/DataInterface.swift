//
//  DataInterface.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public protocol DataInterface {



    func messagesRetrievedFrom(user : User) -> Array<Message>
    func onSelectedCommentTypeId(idtype : IdType) 
    func onCommentsRetrieved() -> Array<Comment>
    func onDataRetrieved() -> Bool
   
    func onCurrentUserRetrieved() -> User!
    func onSelectedUserRetrieved() -> User!
    func onSelectedComment(comment : Comment!)
    func onSelectedCommentRetrieved() -> Comment!
    func onSelectedUser(user : User!)
    func onSelectedCurrentUser(user : User!)
    func onSelectedAlbum(album : Album!)
    func onSelectedAlbumRetrieved() -> Album!
    func onSelectedPhoto(photo : Photo!)
    func onSelectedPhotoRetrieved() -> Photo!
    func onSelectedFeed(feed : Feed!)
    func onSelectedFeedRetrieved() -> Feed!
    
    
    
    func onPhotosRetrieved() -> Array<Photo>
    func onAlbumsRetrieved() -> Array<Album>
    func onUsersRetrieved() -> Array<User>
    func onFriendsRetrieved() -> Array<User>
    func onMessagesRetrievedFrom(user : User) -> Array<Message>
    func onMessagesRetrieved() -> Array<Message>
    func onMessagesFeedRetrieved() -> Array<MessageFeed>
    func onFeedRetrieved() -> Array<Feed>
    func onImgurRetrieved(imgurPhotos_ : Array<ImgurImage>, dataAvailabilityInterface : DataAvailabilityInterface)
    
    
    
    func onSentMessage(message : String)
    func onPostFeed(feed : String, photoFeed : Array<Photo>)
    func onPostedCommentToFeed(comment : String)
    func onPostedCommentToPhoto(comment : String)
 
    func onLogin() -> Bool
    
    func toString( dateFormat format  : String, date : Date ) -> String
    
}
