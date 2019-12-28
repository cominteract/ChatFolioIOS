//
//  MockData.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MockData: NSObject {

    var dateComponents = DateComponents()
    let idMax = 15
    
    var users = Array<User>()
    var comments = Array<Comment>()
    var feeds = Array<Feed>()
    var messages = Array<Message>()
    var photos = Array<Photo>()
    var albums = Array<Album>()
    var imgurPhotos = Array<ImgurImage>()
    var currentUser : User! = nil
    
    var selectedComment : Comment! = nil
    var selectedUser : User! = nil
    var selectedPhoto : Photo! = nil
    var selectedAlbum : Album! = nil
    var selectedType : IdType! = nil
    var selectedFeed : Feed! = nil
    var selectedComments = Array<Comment>()
    var dataInterface: DataInterface! = nil
    override init()
    {
        super.init()
    }
    
    public func initalizeData(dataInterface_ : DataInterface)
    {
        dataInterface = dataInterface_
        initUsers()
        initFriends()
        initPhotos()
    }
    
    public func initalizeDataWithImages(dataInterface_ : DataInterface, imgurPhotos_ : Array<ImgurImage>)
    {
        dataInterface = dataInterface_
        imgurPhotos = imgurPhotos_
        initUsers()
        initFriends()
        initPhotos()
    }
    
    
    private func initUsers()
    {
        for i in 0..<fullnamesArray().count - 2
        {
            let user = User()
            user.userId = randomId(idType: IdType.UserId.rawValue)
            user.userName = usernamesArray()[i]
            user.fullName = fullnamesArray()[i]
            user.profilePicture = photoUrlArray()[i]
            user.userAddress = addressArray()[i]
            user.userDetails = addressArray()[i]
            user.status = randomStatus()
            user.birthday = randomBirthday()
            user.lastMessage = nil
            user.friends = Array<User>()
            user.messages = Array<Message>()
            user.messageFeed = Array<MessageFeed>()
            user.messageFeedUsers = Array<User>()
            user.albums = Array<Album>()
            user.photos = Array<Photo>()
            user.activities = Array<Feed>()
            users.append(user)
        }
    }
    
    private func initFriends()
    {
        for user in users
        {
            for i in 1..<random(1..<11){
                user.friends.append(users[i])}
        }
    }
    
    private func initPhotos()
    {
        for user in users
        {
            user.photos.removeAll()
            user.albums.removeAll()
            for _ in 1..<random(3..<7)
            {
                let albumId = albumArray()[random(0..<albumArray().count)]
                var photosForAlbum = Array<Photo>()
            
                for _ in 1..<random(3..<11) {
                    
                    let photo = Photo()
                    photo.photoId = randomId(idType: IdType.PhotoId.rawValue)
                    photo.comments = Array<Comment>()
                    photo.albumId = albumArray()[random(0..<albumArray().count)]
                    photo.caption = "Random Caption"
                    photo.uploadDate = randomPostDate()
                    photo.user = user
                    photo.imageUrl = imgurPhotos[random(0..<imgurPhotos.count)].link
                    user.photos.append(photo)
                    photosForAlbum.append(photo)
                    photos.append(photo)
      
                }
                let album = Album()
                album.albumId = albumId
                album.photos = photosForAlbum
                album.frontPhotoUrl = photosForAlbum[photosForAlbum.count-1].imageUrl
                album.uploadDate = randomPostDate()
                album.user = user
                user.albums.append(album)
                albums.append(album)
            }
        }
    }
    
    public func initActivities()
    {
        for _ in 1..<120
        {
            let feedType = activitiesArray()[random(0..<activitiesArray().count)]
            if (feedType == (ActivityType.ActivityShare) || feedType == (ActivityType.ActivityPost)
            || feedType == (ActivityType.ActivityPhotoUpload)) {
                var photoArray = Array<Photo>()
                let user = getUserForFeed()
                for _ in 1..<random(1..<4) {
                    let photo = Photo()
                    photo.photoId = randomId(idType: IdType.PhotoId.rawValue)
                    photo.comments = Array<Comment>()
                    photo.albumId = albumArray()[random(0..<albumArray().count)]
                    photo.caption = "Random Caption"
                    photo.uploadDate = randomPostDate()
                    photo.user = user
                    photo.imageUrl = imgurPhotos[random(0..<imgurPhotos.count)].link
                    photoArray.append(photo)
                    photos.append(photo)
                }
                
                let feed = Feed()
                feed.feedId = randomId(idType: IdType.FeedId.rawValue)
                feed.recipient = user
                feed.sender = nil
                feed.activityDetails = "Posted in feed"
                feed.activityImageUrl = imgurPhotos[random(0..<imgurPhotos.count)].link
                feed.activityPhotos = photoArray
                feed.comments = Array<Comment>()
                feed.activityType = feedType
                feed.postDate = randomPostDate()
                feeds.append(feed)
            }
        }
        feeds = feeds.sorted(by: { $0.postDate > $1.postDate })
        //feeds = ArrayList(feeds.sortedWith(CompareFeed))
    }
    
    public func initMessages()
    {
        for user in users
        {
            let messagesCount = random(40..<60)
            for _ in 1..<messagesCount
            {
                let otherUser = users[random(0..<users.count)]
                if(otherUser != user) {
                    let random : String = randomId(idType: IdType.MessageId.rawValue)
                    let date : Date = randomPostDate()
                    let senderMessage = Message()
                    senderMessage.messageId = random
                    senderMessage.recipient = otherUser
                    senderMessage.sender = user
                    senderMessage.chatMessage = " Hey dad what do you think about your son now?"
                    senderMessage.messageDate = date
                    let recipientMessage = Message()
                    recipientMessage.messageId = random
                    recipientMessage.recipient = user
                    recipientMessage.sender = otherUser
                    recipientMessage.chatMessage = " Hey dad what do you think about your son now?"
                    recipientMessage.messageDate = date
                    addLastMessage(user: user,message: senderMessage)
                    addLastMessage(user: otherUser,message: recipientMessage)
                    user.messages.append(senderMessage)
                    otherUser.messages.append(recipientMessage)
                    messages.append(senderMessage)
                    messages.append(recipientMessage)
                }
            }
        }
    }
    
    public func initMessagesFeed()
    {
        for message in messages
        {
            if(isUserInMessages(message: message)) {
                var user : User! = nil
                if(message.sender.isEqual(currentUser))
                {
                    user = message.recipient
                }
                else if(message.recipient.isEqual(currentUser))
                {
                    user = message.sender
                }
                else
                {
                    
                }
            
                //val lastMessage = getMessages(user)[getMessages(user).size-1]

                
                if (!isAlreadyInMessageFeed(user : user) ) {
                    currentUser.messageFeedUsers.append(user)
                    let messageFeed = MessageFeed()
                    messageFeed.messageFeedId = randomId(idType: IdType.MessageFeedId.rawValue)
                    messageFeed.lastMessage = user.lastMessage
                    currentUser.messageFeed.append(messageFeed)
                    //feeds.add(feedFromMessages(lastMessage))
                }
            }
        }
        currentUser.messageFeed = currentUser.messageFeed.sorted(by: { $0.lastMessage.messageDate > $1.lastMessage.messageDate })
        //currentUser!!.messageFeed = Array(currentUser!!.messageFeed.sortedWith(CompareMessageFeed))
    }
    
    public func initComments()
    {
        for _ in 0..<250
        {
            comments.append(randomComment())
        }
        comments = comments.sorted(by: { $0.commentDate < $1.commentDate })
        initCommentsWithId()
        initCommentsFromFeed()
    }
    
    private func initCommentsWithId()
    {
        for _ in 0..<50
        {
            comments[random(0..<comments.count)].replyTo = getCommentWithNoId()
        }
    }
    
    private func initCommentsFromFeed()
    {
        for photo in photos
        {
            
            for _ in 0 ..< random(0..<4)
            {
                let input = random(0..<comments.count-1)
                let comment = comments[input]
                photo.comments.append(comment)
                photo.comments.insert(contentsOf: getCommentsWithReplyToBinary(inputComment: comment, input: input), at: photo.comments.count - 1)
                
                
            //photo.comments.addAll(getCommentsWithReplyTo(comment))
            }
        }
        for feed in feeds
        {
            for _ in 0..<random(0..<4)
            {
                let input = random(0..<comments.count-1)
                let comment = comments[random(0..<comments.count-1)]
                feed.comments.append(comment)
                feed.comments.insert(contentsOf: getCommentsWithReplyToBinary(inputComment: comment, input: input), at: feed.comments.count - 1)
                
                
            }
        }
        for album in albums
        {
            for _ in 0..<random(0..<4)
            {
                let input = random(0..<comments.count-1)
                let comment = comments[random(0..<comments.count-1)]
                album.comments.append(comment)
                album.comments.insert(contentsOf: getCommentsWithReplyToBinary(inputComment: comment, input: input), at: album.comments.count - 1)
            }
        }
    }
    
    public func getCommentsFromSelected() -> Array<Comment>
    {
        if(selectedType == IdType.PhotoId)
        {
            selectedComments = selectedPhoto.comments.sorted(by: { $0.commentDate < $1.commentDate })
        }
        else if(selectedType == IdType.FeedId)
        {
            selectedComments = selectedFeed.comments.sorted(by: { $0.commentDate < $1.commentDate })
        }
        else if(selectedType == IdType.AlbumId)
        {
            selectedComments = selectedAlbum.comments.sorted(by: { $0.commentDate < $1.commentDate })
        }
        return selectedComments
    }
    
    private func getCommentsWithReplyToBinary(inputComment : Comment, input : Int) -> Array<Comment>
    {
    
        var commentsArray = Array<Comment>()
        var start : Int = 0;
        var end : Int = comments.count - 1;
        while (start <= end) {
            let mid : Int = (start + end) / 2;
            let comment = comments[mid]
            if (comment.replyTo == inputComment) {
                commentsArray.append(comment)
            }
            if (input < mid) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }
        return commentsArray;
    }

    
    private func getUserForFeed() -> User
    {
        return [currentUser,users[random(0..<users.count-1)],users[random(0..<users.count-1)],users[random(0..<users.count-1)]][random(0..<4)]
    }
    
    private func feedFromMessages(message: Message) -> Feed
    {
     
        let feed = Feed()
        feed.feedId = randomId(idType: IdType.FeedId.rawValue)
        feed.recipient = currentUser
        feed.sender = message.sender
        feed.activityDetails = "${message.sender.fullName} messaged you in feed"
        feed.activityImageUrl = message.sender.profilePicture
        feed.activityPhotos = Array<Photo>()
        feed.comments = Array<Comment>()
        feed.activityType = ActivityType.ActivityPM
        feed.postDate = message.messageDate

        return feed
    }

    
    private func addLastMessage(user : User, message : Message)
    {
        if(user.lastMessage==nil || (user.lastMessage != nil && user.lastMessage!.messageDate < message.messageDate))
        {
            user.lastMessage = message
        }
    }
    
    private func getCommentWithNoId() -> Comment
    {
        var comment : Comment! = nil
        while (comment==nil)
        {
            comment = comments[random(0..<comments.count)]
            if(comment.replyTo != nil)
            {
                comment = nil
            }
        }
        return comment
    }
    
    public func getMessages(user: User) -> Array<Message>
    {
        var chatMessage = Array<Message>()
        for message in messages {
            if(isChatMessageInSession(user: user,message: message))
            {
                chatMessage.append(message)
            }
        }
        chatMessage = chatMessage.sorted(by: { $0.messageDate < $1.messageDate })
        
        
        for message in chatMessage
        {
            print(message.messageDate)
        }
        
        return chatMessage

    }
    
    private func isChatMessageInSession(user : User, message : Message) -> Bool
    {
        return (message.sender.isEqual(currentUser) && message.recipient.isEqual(user))
            ||  (message.recipient.isEqual(currentUser) && message.sender.isEqual(user))
    }
    
    private func isUserInMessages(message : Message) -> Bool
    {
        return (message.recipient == currentUser || message.sender == currentUser)
    }
    
    public func clearData()
    {
        if(currentUser != nil && currentUser.messageFeedUsers.count > 0)
        {
            selectedUser = nil
            selectedType = nil
            selectedComments.removeAll()
            selectedPhoto = nil
            selectedAlbum = nil
            selectedFeed = nil
            currentUser.messageFeed.removeAll()
            currentUser.messageFeedUsers.removeAll()
        }
        
    }
    
    public func addPost(feedString : String, photoFeed : Array<Photo>)
    {
        let feed  = Feed()
        if(photoFeed.count > 0)
        {
            feed.activityDetails = feedString
            feed.feedId = IdType.FeedId.rawValue
            feed.activityPhotos = photoFeed
            feed.activityImageUrl = photoFeed[photoFeed.count-1].imageUrl
            feed.activityType = ActivityType.ActivityPost
            feed.postDate = Date()
            feed.recipient = currentUser
            feed.sender = nil
            
        }
        else
        {
            feed.activityDetails = feedString
            feed.feedId = IdType.FeedId.rawValue
            feed.activityPhotos = Array<Photo>()
            feed.activityImageUrl = ""
            feed.activityType = ActivityType.ActivityPost
            feed.postDate = Date()
            feed.recipient = currentUser
            feed.sender = nil
            
        }
        feeds.append(feed)
    }
    
    public func addCommentToFeed(commentString : String, replyTo : Comment!)
    {
        let comment = Comment()
        comment.commentId = IdType.CommentId.rawValue
        comment.commentDate = Date()
        comment.comment = commentString
        comment.replyTo = replyTo
        comment.user = currentUser
        comments.append(comment)
        selectedFeed.comments.append(comment)
        
    }
    
    public func addCommentToPhoto(commentString : String, replyTo : Comment!)
    {
        let comment = Comment()
        comment.commentId = IdType.CommentId.rawValue
        comment.commentDate = Date()
        comment.comment = commentString
        comment.replyTo = replyTo
        comment.user = currentUser
        comments.append(comment)
        selectedPhoto.comments.append(comment)
        
    }
    
    public func sendMessage(chatMessage : String)
    {
        let messageId = randomId(idType: IdType.MessageId.rawValue)
        let message = Message()
        message.chatMessage = chatMessage
        message.messageDate = Date()
        message.messageId = messageId
        message.sender = currentUser
        message.recipient = selectedUser
        messages.append(message)
        let otherMessage = Message()
        otherMessage.chatMessage = chatMessage
        otherMessage.messageDate = Date()
        otherMessage.messageId = messageId
        otherMessage.sender = selectedUser
        otherMessage.recipient = currentUser
        
        if (!isAlreadyInMessageFeed(user: message.recipient) ) {
            currentUser.messageFeedUsers.append(message.recipient)
        }
        
        selectedUser.messages.append(otherMessage)
        currentUser.messages.append(message)
        let messageFeed = MessageFeed()
        messageFeed.lastMessage = message
        messageFeed.messageFeedId = randomId(idType: IdType.MessageFeedId.rawValue)
        currentUser.messageFeed.append(messageFeed)
        
        
    
    }
    
    private func isAlreadyInMessageFeed(user : User) -> Bool
    {
   
        if(currentUser.messageFeedUsers.contains(user))
        {
            return true
        }
        return false
    }
    
    private func getOtherMessage(message : Message) -> Message
    {
        let otherMessage = message
        otherMessage.sender = message.recipient
        otherMessage.recipient = message.sender
        return otherMessage
    }
    
    private func randomId (idType : String) -> String {
        
        let letters =
        idType + " " + "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.count)
        
        var randomString = ""
        
        for _ in 0 ..< idMax {
            let randomNum = Int(arc4random_uniform(len))
            let randomIndex = letters.index(letters.startIndex, offsetBy: randomNum)
            let newCharacter = letters[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    private func randomStatus() -> String
    {
        return ["In a Relationship","Single","Married","Complicated"][random(0..<4)]
    }
    
    private func randomComment() -> Comment
    {
        let comment = Comment()
        comment.commentId = IdType.CommentId.rawValue
        comment.commentDate = randomPostDate()
        comment.comment = randomCommentString()
        comment.replyTo = nil
        comment.user = users[random(0..<users.count)]
        //comment.user =
        return comment
    }
    
    private func randomCommentString() -> String
    {
        return ["Random comment","Looking good","Fantastic","Brilliant","Exhilirating",
                "Wow I didnt know that","Nice","Lol","Thanks for this","Mind if I share?",
                "That's definitely a repost"][random(0..<11)]
    }
    
    private func randomBirthday() -> Date
    {
        let randomYear : Int = random(1960..<2019)
        dateComponents.year = randomYear
        dateComponents.month = random(0..<11)
        dateComponents.day = random(0..<30)
        dateComponents.hour = random(0..<23)
        dateComponents.minute = random(0..<59)
        dateComponents.second = random(0..<59)
        dateComponents.calendar = Calendar.current
        return dateComponents.date!
    }
    
    private func randomPostDate() -> Date
    {
        let randomYear : Int = random(2015..<2019)
        dateComponents.year = randomYear
        if(randomYear == 2018)
        {
            dateComponents.month = random(0..<4)
        }
        else
        {
            dateComponents.month = random(0..<11)
        }
        dateComponents.day = random(0..<30)
        dateComponents.hour = random(0..<23)
        dateComponents.minute = random(0..<59)
        dateComponents.second = random(0..<59)
        dateComponents.calendar = Calendar.current
        return dateComponents.date!
    }
    
    private func randomDateBetweenStart(_ start: Date, end: Date) -> Date {
        let window: TimeInterval = end.timeIntervalSince(start)
        let randomOffset: TimeInterval = drand48() * window
        return start.addingTimeInterval(randomOffset) as? Date ?? Date()
    }
//    func random() -> Element
//    {
//        return self[Int(arc4random_uniform(UInt32(self.count)))]
//    }
    
    private func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    private func albumArray() -> Array<String>
    {
        return ["blank","private","outing","gallery","photoshoot","beach","anime","uploads","swimming","hiking","restaurant","foodtrip"]
    }
    
    private func activitiesArray() -> Array<ActivityType>
    {
    return [ActivityType.ActivityChangeDP,ActivityType.ActivityPM,ActivityType.ActivityPhotoUpload,ActivityType.ActivityPost,ActivityType.ActivityShare]
    }
    
    private func addressArray() -> Array<String>
    {
        return ["2445 texas ave"
            ,"8519 abby park st"
            ,"3431 w 6th st"
            ,"5690 smokey ln"
            ,"3753 plum st"
            ,"3138 kraft ave"
            ,"4261 washington ave"
            ,"8867 second st"
            ,"4831 constitution st"
            ,"5094 railroad st"
            ,"1565 camden ave"
            ,"6228 brown terrace"
            ,"4284 elgin st"
            ,"4450 washington rd"
            ,"1534 homestead rd"
            ,"8077 auburn ave"
            ,"1700 corn st"
            ,"8721 parker rd"
            ,"3404 first st"
            ,"8576 lake dr"
            ,"6381 w campbell ave"
            ,"8503 e adele st"
            ,"6230 copper st"
            ,"5135 westheimer rd"
            ,"8564 first street"
            ,"5518 maple rd"
            ,"8239 auburn ave"
            ,"1639 beechcrest rd"
            ,"7665 plum st"
            ,"8536 college st"
            ,"3477 camp st"
            ,"4405 third st"
            ,"3317 ferncliff dr"
            ,"6307 sunset st"
            ,"5543 maple rd"
            ,"8790 corn st"
            ,"6755 ranchview dr"
            ,"1773 lakewview drcowper st"
            ,"6440 main rd"
            ,"5283 james st"
            ,"5938 long rapids rd"
            ,"3218 airplane ave"
            ,"4475 lovers ln"
            ,"3524 thornridge cir"
            ,"3096 robinson rd"
            ,"1927 sweards bluff ave"]
    }
    
    private func fullnamesArray() -> Array<String>
    {
        return ["mrs ariane scott"
            ,"ms jen dunn"
            ,"ms caroline hansen"
            ,"mr mason price"
            ,"mr same may"
            ,"ms eloise clement"
            ,"mr aymeric sanchez"
            ,"mrs maria madsen"
            ,"mr ayhan vlemmix"
            ,"mr claude riley"
            ,"mr borre tolenaars"
            ,"ms carmen byrd"
            ,"ms juliette wilson"
            ,"mrs julia lord"
            ,"mrs bilge den boef"
            ,"ms leonaura aragao"
            ,"mr mustafa akgul"
            ,"mr carlo leeflang"
            ,"mr batur bolatli"
            ,"ms morgane michel"
            ,"ms vicki franklin"
            ,"ms pinja sakala"
            ,"mrs mia thomas"
            ,"mr nicolas martin"
            ,"ms wilma schmitz"
            ,"mr topias peura"
            ,"mr andreas nielsen"
            ,"mr aitor diez"
            ,"mrs stella arnaud"
            ,"mr oguzhan yeşilkaya"
            ,"mrs becky george"
            ,"mr cameron day"
            ,"mr ewen lemoine"
            ,"mr ronald kelley"
            ,"mr gregorio marin"
            ,"mr ernest hall"
            ,"mr gilbert rodriguez"
            ,"mr victor gauthier"
            ,"ms coline denis"
            ,"mrs holly kumar"
            ,"mr kuzey karaer"
            ,"ms eva lynch"
            ,"mr jaime cortes"
            ,"mr taoufik rosenberg"
            ,"mr russell banks"
            ,"mr micah geurten"]
    }
    
    private func usernamesArray() -> Array<String>
    {
        return ["biglion848"
            ,"purplebutterfly355"
            ,"organictiger653"
            ,"ticklishrabbit682"
            ,"yellowfish547"
            ,"redbear998"
            ,"ticklishdog395"
            ,"yellowrabbit911"
            ,"blueelephant326"
            ,"tinykoala433"
            ,"yellowpanda168"
            ,"whitepanda924"
            ,"blackbear723"
            ,"smallbear637"
            ,"bigduck549"
            ,"redrabbit491"
            ,"greenbear131"
            ,"goldenpanda177"
            ,"greenbird755"
            ,"greenfish500"
            ,"yellowelephant335"
            ,"biglion771"
            ,"bluepanda322"
            ,"blackbear464"
            ,"tinymeercat470"
            ,"whitepanda158"
            ,"lazyfrog151"
            ,"crazyfish646"
            ,"blackkoala749"
            ,"ticklishostrich356"
            ,"goldenswan883"
            ,"greenladybug550"
            ,"smallsnake385"
            ,"organiclion784"
            ,"greenbutterfly641"
            ,"ticklishgorilla690"
            ,"reddog435"
            ,"organicrabbit704"
            ,"greendog921"
            ,"blackfish168"
            ,"purpledog586"
            ,"tinybear524"
            ,"blackdog563"
            ,"brownmeercat206"
            ,"silverbutterfly420"]
    }
    
    private func photoUrlArray() -> Array<String>
    {
        return ["https://randomuser.me/api/portraits/med/women/6.jpg"
            ,"https://randomuser.me/api/portraits/med/women/22.jpg"
            ,"https://randomuser.me/api/portraits/med/women/25.jpg"
            ,"https://randomuser.me/api/portraits/med/men/47.jpg"
            ,"https://randomuser.me/api/portraits/med/men/95.jpg"
            ,"https://randomuser.me/api/portraits/med/women/27.jpg"
            ,"https://randomuser.me/api/portraits/med/men/14.jpg"
            ,"https://randomuser.me/api/portraits/med/women/87.jpg"
            ,"https://randomuser.me/api/portraits/med/men/89.jpg"
            ,"https://randomuser.me/api/portraits/med/men/72.jpg"
            ,"https://randomuser.me/api/portraits/med/men/53.jpg"
            ,"https://randomuser.me/api/portraits/med/women/68.jpg"
            ,"https://randomuser.me/api/portraits/med/women/53.jpg"
            ,"https://randomuser.me/api/portraits/med/women/42.jpg"
            ,"https://randomuser.me/api/portraits/med/women/30.jpg"
            ,"https://randomuser.me/api/portraits/med/women/46.jpg"
            ,"https://randomuser.me/api/portraits/med/men/70.jpg"
            ,"https://randomuser.me/api/portraits/med/men/39.jpg"
            ,"https://randomuser.me/api/portraits/med/men/33.jpg"
            ,"https://randomuser.me/api/portraits/med/women/29.jpg"
            ,"https://randomuser.me/api/portraits/med/women/40.jpg"
            ,"https://randomuser.me/api/portraits/med/women/26.jpg"
            ,"https://randomuser.me/api/portraits/med/women/86.jpg"
            ,"https://randomuser.me/api/portraits/med/men/32.jpg"
            ,"https://randomuser.me/api/portraits/med/women/69.jpg"
            ,"https://randomuser.me/api/portraits/med/men/27.jpg"
            ,"https://randomuser.me/api/portraits/med/men/50.jpg"
            ,"https://randomuser.me/api/portraits/med/men/93.jpg"
            ,"https://randomuser.me/api/portraits/med/women/70.jpg"
            ,"https://randomuser.me/api/portraits/med/men/36.jpg"
            ,"https://randomuser.me/api/portraits/med/women/30.jpg"
            ,"https://randomuser.me/api/portraits/med/men/49.jpg"
            ,"https://randomuser.me/api/portraits/med/men/62.jpg"
            ,"https://randomuser.me/api/portraits/med/men/57.jpg"
            ,"https://randomuser.me/api/portraits/med/men/85.jpg"
            ,"https://randomuser.me/api/portraits/med/men/34.jpg"
            ,"https://randomuser.me/api/portraits/med/men/47.jpg"
            ,"https://randomuser.me/api/portraits/med/men/37.jpg"
            ,"https://randomuser.me/api/portraits/med/women/92.jpg"
            ,"https://randomuser.me/api/portraits/med/women/76.jpg"
            ,"https://randomuser.me/api/portraits/med/men/49.jpg"
            ,"https://randomuser.me/api/portraits/med/women/91.jpg"
            ,"https://randomuser.me/api/portraits/med/men/24.jpg"
            ,"https://randomuser.me/api/portraits/med/men/24.jpg"
            ,"https://randomuser.me/api/portraits/med/men/51.jpg"
            ,"https://randomuser.me/api/portraits/med/men/10.jpg"]
    }
    
    private func emailArray() -> Array<String>
    {
        return ["ariane.scott@example.com"
            ,"jen.dunn@example.com"
            ,"caroline.hansen@example.com"
            ,"mason.price@example.com"
            ,"same.may@example.com"
            ,"eloïse.clement@example.com"
            ,"aymeric.sanchez@example.com"
            ,"maria.madsen@example.com"
            ,"ayhan.vlemmix@example.com"
            ,"claude.riley@example.com"
            ,"borre.tolenaars@example.com"
            ,"carmen.byrd@example.com"
            ,"juliette.wilson@example.com"
            ,"julia.lord@example.com"
            ,"bilge.denboef@example.com"
            ,"leonaura.aragão@example.com"
            ,"mustafa.akgül@example.com"
            ,"carlo.leeflang@example.com"
            ,"batur.bolatlı@example.com"
            ,"morgane.michel@example.com"
            ,"vicki.franklin@example.com"
            ,"pinja.sakala@example.com"
            ,"mia.thomas@example.com"
            ,"nicolas.martin@example.com"
            ,"wilma.schmitz@example.com"
            ,"topias.peura@example.com"
            ,"andreas.nielsen@example.com"
            ,"aitor.diez@example.com"
            ,"stella.arnaud@example.com"
            ,"oğuzhan.yeşilkaya@example.com"
            ,"becky.george@example.com"
            ,"cameron.day@example.com"
            ,"ewen.lemoine@example.com"
            ,"ronald.kelley@example.com"
            ,"gregorio.marin@example.com"
            ,"ernest.hall@example.com"
            ,"gilbert.rodriquez@example.com"
            ,"victor.gauthier@example.com"
            ,"coline.denis@example.com"
            ,"holly.kumar@example.com"
            ,"kuzey.karaer@example.com"
            ,"eva.lynch@example.com"
            ,"jaime.cortes@example.com"
            ,"taoufik.rosenberg@example.com"
            ,"russell.banks@example.com"
            ,"micah.geurten@example.com"]
    }
    
}
