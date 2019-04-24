//
//  ChatLogController.swift
//  ChatApp
//
//  Created by Macbook on 4/21/19.
//  Copyright © 2019 Spiritofthecore. All rights reserved.
//

import UIKit

class ChatLogController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    private let cellID = "cellID"
    let tableView = UITableView()
    var friend: Friend? {
        didSet{
            navigationItem.title = friend?.name
            
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.register(ChatLogMessageCell.self, forCellReuseIdentifier: cellID)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
    }
}


class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.textAlignment = .center
        return textView
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(messageTextView)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        messageTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        messageTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
