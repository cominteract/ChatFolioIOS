//
//  AppTransitionInterface.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public protocol AppTransitionInterface {
    func didMoveToProfile()
    func didMoveToPhotoFull()
    func didMoveToFeedFull()
    func didMoveToChat()
    func onInterfaceLoaded()
    
}
