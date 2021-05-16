//
//  CompletedTaskListTableViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/8/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CompletedTaskListTableViewController: UITableViewController {
  var tasksInCompleted: [String] = []
  var tasks : [Task] = []
  var roomIdentifier: String? = nil
  var counter: String? = nil
  var database = Database.database();
  let ref = Database.database().reference()
  
  override func viewDidLoad() {
    tasks.removeAll()

    ref.child(roomIdentifier!).child("taskList").observe(.value, with: { snapshot in
      // Get NSDictionary of user tasks
      let taskProfiles = snapshot.value as? NSDictionary

      // Unwrap roommateProfiles
      guard let tasks = taskProfiles else { return }

      // Iterate through NSDictionary
      for (key, value) in tasks {
        // Cast task as a Swift Dictionary
        let taskDict = (value as! [String : Any])
        
        let checkCompleted = taskDict["completed"] as! String
        
        if checkCompleted == "true" {
          // If checkCompleted is true, add it to the array that will be used to show up on this page
          let id = key
          let important = taskDict["important"]
          let name = taskDict["name"]
          // Set false to send
          let completed = "false"

          self.tasks.append(
            Task(
              idCounter: id as! String,
              name: name as! String,
              important: important as! String,
              completed: completed as! String
            )
          )
        }

        self.tableView.reloadData()
      }
    })
    { (error) in
      print(error.localizedDescription)
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Initialize with random dummy value
    var uniqueName: Set = ["blobfish5000000xr"]
    var uniqueTasks : [Task] = []
    for thing in tasks {
      if thing.completed == "true" {
        uniqueName.insert(thing.name)
      }
      if !uniqueName.contains(thing.name) {
        uniqueTasks.append(thing)
        uniqueName.insert(thing.name)
      }
    }
    return uniqueTasks.count
  }
      
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell", for: indexPath)
    cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
    
    // Distinct array to fix doubling issue
    // Initialize with random dummy value
    var uniqueName: Set = ["blobfish5000000xr"]
    var uniqueTasks : [Task] = []
    for thing in tasks{
      if thing.completed == "true"{
        uniqueName.insert(thing.name)
      }
      if !uniqueName.contains(thing.name) {
        uniqueTasks.append(thing)
        uniqueName.insert(thing.name)
      }
    }

    let task = uniqueTasks[indexPath.row]

    // cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
    if task.important == "true" {
      cell.textLabel?.text = task.name
    }
    else {
      cell.textLabel?.text = task.name
    }
    return cell
  }
}
