//
//  MessageListViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit

class MessagesListViewController: UITableViewController {
    var messages: [Message] = []
    
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
}
