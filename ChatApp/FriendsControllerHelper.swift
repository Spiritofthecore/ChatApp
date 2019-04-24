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

            
           let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve"

            let bill = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            bill.name = "Bill Clinton"
            bill.profileImageName = "bill"
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            createMessage(text: "Good morning", friend: steve, minutesAgo: 60, context: context)
            createMessage(text: "Your fb is dabezt", friend: mark, minutesAgo: 3, context: context)
            createMessage(text: "You should buy iSomething", friend: steve, minutesAgo: 2, context: context)
            createMessage(text: "You're doing good, Trump", friend: bill, minutesAgo: 1, context: context)
            createMessage(text: "Love, Peace, and Joy", friend: gandhi, minutesAgo: 60 * 24 * 10000, context: context)
            
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
            let fetchRequestMessage = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            let fetchRequestFriend = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequestMessage)
            let batchDeleteRequestFriend = NSBatchDeleteRequest(fetchRequest: fetchRequestFriend)
            
            do {
                try context.execute(batchDeleteRequest)
            } catch let err {
                print(err)
            }
            
            do {
                try context.execute(batchDeleteRequestFriend)
            } catch let err {
                print(err)
            }
        }
    }
    
    func createMessage(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo*60)
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            if let friends = fetchFriends(){
                messages = [Message]()
                for friend in friends {
                    print(friend.name!)
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.returnsObjectsAsFaults = false
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    if let friendName = friend.name {
                     fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friendName)
                    }
                    fetchRequest.fetchLimit = 1
                    do {
                        let fetchMessages = try(context.fetch(fetchRequest)) as? [Message]
                        messages?.append(contentsOf: fetchMessages!)
                    } catch let err {
                        print(err)
                    }
                }
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                return (try context.fetch(fetchRequest)) as? [Friend]
            } catch let err{
                print(err)
            }
        }
        return nil
    }
}
