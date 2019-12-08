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
    var messages: [String] = []
    var timeStamp = ""
    var passedContent = "Leave an anonymous message"
    var roomIdentifier: String? = nil
    
    // From Code with Chris on YouTube
    // @IBAction func createMessage() {
//        print("createmessage was called")
//        /*self.messages.append(Message(
//            id: id as! Int32,
//            content: content as! String
//            //currentTime: currentTime as! String
//        ))
//        var newPostKey = ref.child(roomIdentifier!).child("messages").setValue(["id": messages[idCounter].id])
//        //reload()
//        */
//
//        timeStamp = Date().time()
//        print(timeStamp)
//        let messageData: Message = Message(content: "Default", currentTime: timeStamp)
//        // Create messageData dictionary
//
//        // Upload user message to the cloud
//        let ref = Database.database().reference()
////        ref.child(self.roomIdentifier!).child("messageBoard").child(timeStamp.replacingOccurrences(of: " ", with: "_")).setValue([
////            "content": messageData.content,
////            "currentTime": messageData.currentTime
////        ])
//        ref.child(self.roomIdentifier!).child("messageBoard").child(timeStamp.replacingOccurrences(of: " ", with: "_")).setValue("Hello world")
//        //print("createMessage happened")
//
//        /*self.messages.append(messageData)
//        print(messages)
//        var count = 0
//        for thing in messages{
//            print(thing.content)
//            print(thing.currentTime)
//            print(String(count))
//            count = count + 1
//        }
//         */
        
        
    // }

    
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
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
//        print("viewDidLoad start")
//        print(messages)
//        let ref = Database.database().reference()
//        ref.child(roomIdentifier!).child("messageBoard").observe(.value, with: { (snapshot) in
//            // Get NSDictionary of user messages
//            let roommateMessages = snapshot.value as? NSDictionary
//
//            // Unwrap roommateMessages
//            guard let firebaseMessages = roommateMessages else { return }
//
//            // Iterate through NSDictionary
//            for (key, value) in firebaseMessages {
//                // Cast message as a Swift Dictionary
//                let messageDict = (value as! [String : Any])
//                print(messageDict)
//
//                // Unwrap each property of message
//                guard let content = messageDict["content"] else { return }
//                guard let currentTime = messageDict["currentTime"] else { return }
//
//                // Append new Roommate to result Array
//                self.messages.append(Message(
//                    content: content as! String,
//                    currentTime: currentTime as! String
//                ))
//                self.tableView.reloadData()
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        print("viewDidLoad end")
//        print(messages)'
        
        // From Code with Chris on YouTube
        let ref = Database.database().reference()
        ref.child(roomIdentifier!).child("messageBoard").observe(.childAdded) { (snapshot) in
            let message = snapshot.value as? String
            guard let actualMessage = message else { return }
            self.messages.append(actualMessage)
            self.tableView.reloadData()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageSegue",
                let destination = segue.destination as? MessageViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.messageContent = messages[index]
            destination.roomIdentifier = roomIdentifier
        } else if segue.identifier == "CreateMessageSegue", let destination = segue.destination as? CreateMessageViewController {
            print("Performed segue")
            destination.roomIdentifier = roomIdentifier
            let timeStamp = Date().time().replacingOccurrences(of: " ", with: "_")
            print(timeStamp)
            destination.timeStamp = timeStamp
        }
        //var vc = segue.destination as! MessageViewController
        //passedContent = vc.contentTextView.text
        
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
