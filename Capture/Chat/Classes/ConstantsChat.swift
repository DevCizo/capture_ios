//
//  Constants.swift
//  sample-chat-swift
//
//  Created by Anton Sokolchenko on 3/30/15.
//  Copyright (c) 2015 quickblox. All rights reserved.
//


import UIKit


// My

let kQBApplicationID:UInt = 74689
let kQBAuthKey = "vNB3HXBOcFGsuqu"
let kQBAuthSecret = "wWPA9qtOXmtufh4"
let kQBAccountKey = "abcEqcbqbkwy-jMPKZkB"


//let kQBApplicationID:UInt = 74730
//let kQBAuthKey = "vxPxv2-HKLcD9VX"
//let kQBAuthSecret = "DqQ76WzFhFSu-vf"
//let kQBAccountKey = "9VY99giphixKEfDxCJy_"


let kChatPresenceTimeInterval:TimeInterval = 45
let kDialogsPageLimit:UInt = 100
let kMessageContainerWidthPadding:CGFloat = 40.0



class Constants {
	
    class var QB_USERS_ENVIROMENT: String {
		
#if DEBUG
        return "dev"
#elseif QA
        return "qbqa"
#else
    assert(false, "Not supported build configuration")
    return ""
#endif
        
    }
}
