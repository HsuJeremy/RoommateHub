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

        //let ref = Database.database().reference()
        ref.child(roomIdentifier!).child("taskList").observe(.value, with: { (snapshot) in
            // Get NSDictionary of user tasks
            let taskProfiles = snapshot.value as? NSDictionary

            // Unwrap roommateProfiles
            guard let tasks = taskProfiles else { return }

            // Iterate through NSDictionary
            //tasks holds everything
            for (key, value) in tasks {
                // Cast task as a Swift Dictionary
                let taskDict = (value as! [String : Any])
                let name = key //this is the idNumber
                let important = value //this is {completed = false;important = false;name = hi;}
                
                let checkCompleted = taskDict["completed"] as! String
                
                if checkCompleted == "true"{
                    //if checkCompleted is true then add it to the array that will be used to show up on this page
                    let id = key
                    let important = taskDict["important"]
                    let name = taskDict["name"]
                    let completed = "false"//taskDict["completed"] //thurn this false to send

                    // Append new task to result Array
                    self.tasks.append(Task(
                        idCounter: id as! String,
                        name: name as! String,
                        important: important as! String,
                        completed: completed as! String
                    ))
                    //tasks holds everything
                }

                self.tableView.reloadData()
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if thing.completed == "true"{
                uniqueName.insert(thing.name)
            }
            if !uniqueName.contains(thing.name) {
                //it's a new one!
                uniqueTasks.append(thing) //add to uniqueTasks
                uniqueName.insert(thing.name) //add it in
            }
        }
        return uniqueTasks.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell", for: indexPath)
        
        //DISTINCT ARRAAYYYAYAYAYAYA to fix doubling issue
        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if thing.completed == "true"{
                uniqueName.insert(thing.name)
            }
            if !uniqueName.contains(thing.name) {
                //it's a new one!
                uniqueTasks.append(thing) //add to uniqueTasks
                uniqueName.insert(thing.name) //add it in
            }
        }

        let task = uniqueTasks[indexPath.row]

        //cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        if task.important == "true" {
            cell.textLabel?.text = task.name 
        }
        else{
            cell.textLabel?.text = task.name
        }
        return cell
    }
}
