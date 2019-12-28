//
//  ChatFolioManager.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChatFolioManager: NSObject,DataInterface {
    func onImgurRetrieved(imgurPhotos_: Array<ImgurImage>, dataAvailabilityInterface : DataAvailabilityInterface) {
        mockData.initalizeDataWithImages(dataInterface_: self, imgurPhotos_: imgurPhotos_)
        isInitialized = true
        dataAvailabilityInterface.onMockDataRetrieved()
    }
    
    func toString(dateFormat format: String, date: Date) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    

   
    
   
    
  
    
    let dateFormatter = DateFormatter()
    var isInitialized = false
    var isLogged = false
    

    var mockData : MockData! = MockData()

    
    func onMessagesRetrievedFrom(user: User) -> Array<Message> {
        return mockData.getMessages(user:user)
    }
    
    func onSelectedFeed(feed: Feed!) {
        mockData.selectedFeed = feed
    }
    
    func onSelectedFeedRetrieved() -> Feed! {
        return mockData.selectedFeed
    }
    
    
    func messagesRetrievedFrom(user: User) -> Array<Message> {
        return mockData.getMessages(user:user)
    }
    
    func onSelectedCommentTypeId(idtype: IdType){
        mockData.selectedType = idtype
    }
    
    func onCommentsRetrieved() -> Array<Comment> {
        return mockData.getCommentsFromSelected()
    }
    
    func onDataRetrieved() -> Bool {
        return isInitialized
    }
    
    func onCurrentUserRetrieved() -> User! {
        return mockData.currentUser
    }
    
    func onSelectedUserRetrieved() -> User! {
        return mockData.selectedUser
    }
    
    func onSelectedComment(comment: Comment!) {
        mockData.selectedComment = comment
    }
    
    func onSelectedCommentRetrieved() -> Comment! {
        return mockData.selectedComment
    }
    
    func onSelectedUser(user: User!) {
        mockData.selectedUser = user
    }
    
    func onSelectedCurrentUser(user: User!) {
        if(user != nil) {
            
            mockData.currentUser = user
      
            if(mockData.currentUser.friends.contains(user))
            {
                mockData.currentUser.friends.remove(at: mockData.currentUser.friends.index(of: user)!)
            }
            if(mockData.messages.count < 1) {
                mockData.initMessages()
                mockData.initActivities()
                mockData.initComments()
            }
            mockData.clearData()
            mockData.initMessagesFeed()
       
            
            isLogged = true
        }
        else
        {
            isLogged = false
        }
    }
    
    func onSelectedAlbum(album: Album!) {
        mockData.selectedAlbum = album
    }
    
    func onSelectedAlbumRetrieved() -> Album! {
        return mockData.selectedAlbum
    }
    
    
    
    func onSelectedPhoto(photo: Photo!) {
        mockData.selectedPhoto = photo
    }
    
    func onSelectedPhotoRetrieved() -> Photo! {
        return mockData.selectedPhoto
    }
    
    func onPhotosRetrieved() -> Array<Photo> {
        if(mockData.selectedUser != nil){
            return mockData.selectedUser.photos }
        return mockData.currentUser.photos
    }
    
    func onAlbumsRetrieved() -> Array<Album> {
        if(mockData.selectedUser != nil){
            return mockData.selectedUser.albums}
        return mockData.currentUser.albums
    }
    
    func onUsersRetrieved() -> Array<User> {
        return mockData.users
    }
    
    func onFriendsRetrieved() -> Array<User> {
        return mockData.currentUser.friends
    }
    
    func onMessagesRetrieved() -> Array<Message> {
        return mockData.currentUser.messages
    }
    
    func onMessagesFeedRetrieved() -> Array<MessageFeed> {
        return mockData.currentUser.messageFeed
    }
    
    func onFeedRetrieved() -> Array<Feed> {
        return mockData.feeds
    }
    
    func onSentMessage(message: String) {
        mockData.sendMessage(chatMessage: message)
    }
    
    func onPostFeed(feed: String, photoFeed: Array<Photo>) {
        mockData.addPost(feedString: feed, photoFeed: photoFeed)
    }
    
    func onPostedCommentToFeed(comment: String) {
        
        mockData.addCommentToFeed(commentString: comment, replyTo: onSelectedCommentRetrieved())
    }
    
    func onPostedCommentToPhoto(comment: String) {
        mockData.addCommentToPhoto(commentString: comment, replyTo: onSelectedCommentRetrieved())
    }
    
    func onLogin() -> Bool {
        return isLogged
    }
    
    public func initalizeManager(dataAvailabilityInterface : DataAvailabilityInterface)
    {
        
        let imgurApi = AFImgurRequest()
        imgurApi.startImgurRequest(dataInterface: self, dataAvailabilityInterface : dataAvailabilityInterface)
  
    }
    

}
