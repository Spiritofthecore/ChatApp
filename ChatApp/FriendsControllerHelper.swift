//
//  File.swift
//  ChatApp
//
//  Created by Macbook on 4/16/19.
//  Copyright © 2019 Spiritofthecore. All rights reserved.
//

import Foundation

extension FriendsController {
    
    func setupData() {
        
        
        
        let mark = Friend()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "mark"
        
        let message = Message()
        message.friend = mark
        message.text = "Hello, your fb is blocked :))"
        message.date = NSDate()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Hello, my iPhone is dabetz"
        messageSteve.date = NSDate()
        
        messages = [message, messageSteve]
    }
}
