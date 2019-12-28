//
//  AdapterInteractionInterface.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

public protocol AdapterInteractionInterface {
    func onClickImage(adapterType : AdapterType)
    func onClickTitle(adapterType : AdapterType)
    func onClickDate(adapterType : AdapterType)
    func onClickComment(adapterType : AdapterType)
}
