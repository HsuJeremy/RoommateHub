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

// kanshuYokoo from coderwall.com date timestamp formatting
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
    var roomIdentifier: String? = nil

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
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
    }
}
