//
//  TaskListTableViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
import UIKit
import FirebaseDatabase

// kanshuYokoo from coderwall.com date timestamp formatting
extension Date {
    func timer() -> String! {
        let date = Date()
        let format = DateFormatter()
        
        format.dateFormat = "MMddHHmmss"
        let formattedDate = format.string(from: date)
        
        return(formattedDate)
    }
}

class TaskListTableViewController: UITableViewController {
    
    var tasksInCompleted: [String] = []
    var tasks : [Task] = []
    var roomIdentifier: String? = nil
    var counter: String? = nil
    var database = Database.database();
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        tasks.removeAll()
        ref.child(roomIdentifier!).child("taskList").observe(.value, with: { (snapshot) in
            // Get NSDictionary of user tasks
            let taskProfiles = snapshot.value as? NSDictionary

            // Unwrap roommateProfiles
            guard let tasks = taskProfiles else { return }

            // Iterate through NSDictionary
            // Tasks holds everything
            for (key, value) in tasks {
                // Cast task as a Swift Dictionary
                let taskDict = (value as! [String : Any]) // ["completed": false, "name": hi, "important": false]
                
                // taskDict["completed"] prints Optional(false)
                let checkCompleted = taskDict["completed"] as! String
                
                if checkCompleted == "false" {
                    // If checkCompleted is false then add it to the array that will be used to show up on this page
                    let id = key
                    let important = taskDict["important"]
                    let name = taskDict["name"]
                    let completed = taskDict["completed"]

                    // Append new task to result Array
                    self.tasks.append(Task(
                        idCounter: id as! String,
                        name: name as! String,
                        important: important as! String,
                        completed: completed as! String
                    ))
                    // Tasks holds everything
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This is a dummy name value to initialize (nothing will have this name)
        var uniqueName: Set = ["blobfish5000000xr"]
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                // Append to uniqueTasks
                uniqueTasks.append(thing)
                uniqueName.insert(thing.name)
            }
        }
        return uniqueTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        // Distinct Array to fix doubling issue
        var uniqueName: Set = ["blobfish5000000xr"] // This is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                // Append to uniqueTasks
                uniqueTasks.append(thing)
                uniqueName.insert(thing.name)
            }
        }
        let task = uniqueTasks[indexPath.row]
        
        cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        if task.important == "true" {
            cell.textLabel?.text = task.name + " ❗️"
        } else {
            cell.textLabel?.text = task.name
        }
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Distinct Array to fix doubling issue
        var uniqueName: Set = ["blobfish5000000xr"] // This is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                // Append to uniqueTasks
                uniqueTasks.append(thing)
                uniqueName.insert(thing.name)
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "isCompletedSegue", let destination = segue.destination as? TaskCompletedViewController, let index = tableView.indexPathForSelectedRow?.row {
                destination.task = uniqueTasks[index]
                destination.roomIdentifier = roomIdentifier
            }
        else if segue.identifier == "AddTaskSegue", let destination = segue.destination as? TaskAddViewController {
            destination.roomIdentifier = roomIdentifier
            let counter = Date().timer()
            destination.counter = counter!
        }
        else if segue.identifier == "CompletedTaskListSegue", let destination = segue.destination as? CompletedTaskListTableViewController {
            destination.roomIdentifier = roomIdentifier
        }
    }
}
