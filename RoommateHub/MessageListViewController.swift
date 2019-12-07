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

//coderwall.com date timestamp formatting
extension Date {
    func time() -> String! {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        /*
        let calendar = Calendar.current
        calendar.component(.year, from: date)
        calendar.component(.month, from: date)
        calendar.component(.day, from: date)
*/
        
        return(formattedDate)
    }
}

class MessagesListViewController: UITableViewController {
    var messages: [Message] = []
    var timeStamp = ""
    let ref = Database.database().reference()
    var roomIdentifier: String? = nil
    
    @IBAction func createMessage() {
        print("createmessage was called")
        /*self.messages.append(Message(
            id: id as! Int32,
            content: content as! String
            //currentTime: currentTime as! String
        ))
        var newPostKey = ref.child(roomIdentifier!).child("messages").setValue(["id": messages[idCounter].id])
        //reload()
        */
        
        //ref.setValue(Message(content = "henlooo", currentTime: "nunya"))
        
        timeStamp = Date().time()
        print(timeStamp)
        var messageData: Message = Message(content: "yodawg", currentTime: timeStamp)
        // Create profileData dictionary
                
        // Upload user profile to the cloud
        let ref = Database.database().reference()
        ref.child(self.roomIdentifier!).child("messageBoard").child(timeStamp.replacingOccurrences(of: " ", with: "_")).setValue([
            "content": messageData.content,
            "currentTime": messageData.currentTime
        ])
        //print("createMessage happened")
        
        self.messages.append(messageData)
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reload()
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
        
        ref.child(roomIdentifier!).child("messageBoard").observe(.value, with: { (snapshot) in
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

                // Append new Message to result Array
                self.messages.append(Message(
                    content: content as! String,
                    currentTime: currentTime as! String
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

/*
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageSegue",
                let destination = segue.destination as? MessageViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.message = messages[index]
        }
    }
    
    func writeNewPost(content currentTime: String) {
        let ref = Database.database().reference()

      // Get a key for a new Post.
        var newPostKey = Database.database().ref().child(roomIdentifier!).child("messages").push().key

      // Write the new post's data simultaneously in the posts list and the user's post list.
      var updates = {};
      updates["messages" + messages.id] = postData

        return ref.update(updates)
    }

}
 
 */
