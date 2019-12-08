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

//kanshuYokoo from coderwall.com date timestamp formatting
extension Date {
    func time() -> String! {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        
        return(formattedDate)
    }
}

class MessagesListViewController: UITableViewController {
    var messages: [Message] = []
    var timeStamp = ""
    var passedContent = "Leave an anonymous message"
    let ref = Database.database().reference()
    var roomIdentifier: String? = nil
    
    @IBAction func createMessage() {
        self.messages.removeAll()

        print("createmessage was called")
        /*self.messages.append(Message(
            id: id as! Int32,
            content: content as! String
            //currentTime: currentTime as! String
        ))
        var newPostKey = ref.child(roomIdentifier!).child("messages").setValue(["id": messages[idCounter].id])
        //reload()
        */
        
        timeStamp = Date().time()
        //print(timeStamp)
        let messageData: Message = Message(content: "Default", currentTime: timeStamp)
        // Create messageData dictionary
                
        // Upload user message to the cloud
        let ref = Database.database().reference()
        ref.child(self.roomIdentifier!).child("messageBoard").child(timeStamp.replacingOccurrences(of: " ", with: "_")).setValue([
            "content": messageData.content,
            "currentTime": messageData.currentTime
        ])
    }

    
    override func viewWillAppear(_ animated: Bool) {
        //self.messages.removeAll()

        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
        self.messages.removeAll()

        ref.child(roomIdentifier!).child("messageBoard").observe(.childAdded, with: { (snapshot) in
            // Get NSDictionary of user messages
            let roommateMessages = snapshot.value as? NSDictionary
            
            // Unwrap roommateMessages
            guard let roomieMessages = roommateMessages else { return }
            
            // Iterate through NSDictionary
            for (key, value) in roomieMessages {
                // Cast message as a Swift Dictionary
                let messageDict = (value as! [String : Any])
                print(messageDict)
                
                // Unwrap each property of message
                guard let content = messageDict["content"] else { return }
                guard let currentTime = messageDict["currentTime"] else { return }
                                
                // Append new Roommate to result Array
                self.messages.append(Message(
                    content: content as! String,
                    currentTime: currentTime as! String
                ))
                print("From viewDidLoad")
                print(roomieMessages)
            }
            self.tableView.reloadData()

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageSegue",
                let destination = segue.destination as? MessageViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.message = messages[index]
            destination.roomIdentifier = roomIdentifier
        }
    }
    
}
