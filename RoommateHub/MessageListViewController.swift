//
//  MessageListViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class MessagesListViewController: UITableViewController {
    var messages: [Message] = []
    var roomIdentifier: String? = nil
    
    @IBAction func createMessage() {
        let _ = MessageManager.shared.create()
        reload()
    }
    
    //reloads tableview
    func reload() {
        messages = MessageManager.shared.getMessages() //give all the messages that are currently in the database
        tableView.reloadData() //reload data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].content
        return cell
    }
    
    override func viewDidLoad() {
        let ref = Database.database().reference()
        
        ref.child(roomIdentifier!).observe(.value, with: { (snapshot) in
            // Get NSDictionary of messages on the roommate message board
            let roommateMessageBoard = snapshot.value as? NSDictionary
            
            // Unwrap roommateMessageBoard
            guard let messageBoard = roommateMessageBoard else { return }
            
            // Iterate through NSDictionary
            for (key, value) in messageBoard {
                // Cast messageBoard as a Swift Dictionary
                let messageBoardDict = (value as! [String : Any])
                print(messageBoardDict)
                
                // Unwrap each property of profile
                guard let id = messageBoardDict["id"] else { return }
                guard let content = messageBoardDict["content"] else { return }
                guard let currentTime = messageBoardDict["currentTime"] else { return }

                // Append new Roommate to result Array
                self.messages.append(Message(
                    id: id as! Int32,
                    content: content as! String
                    //currentTime: currentTime as! String
                ))
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageSegue",
                let destination = segue.destination as? MessageViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.message = messages[index]
        }
    }
}

