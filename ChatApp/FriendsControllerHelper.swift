//
//  File.swift
//  ChatApp
//
//  Created by Macbook on 4/16/19.
//  Copyright © 2019 Spiritofthecore. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func setupData() {
        clearData()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "mark"
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello, your fb is blocked :))"
            message.date = NSDate()
            
           let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve"
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Hello, my iPhone is dabetz"
            messageSteve.date = NSDate()
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
//            messages = [message, messageSteve]
        }
        loadData()
    }
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
            } catch let err {
                print(err)
            }
        }
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                messages = (try context.fetch(fetchRequest)) as? [Message]
            } catch let err {
                print(err)
            }
        }
    }
}
