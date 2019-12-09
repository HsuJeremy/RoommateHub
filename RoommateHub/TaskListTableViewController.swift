//
//  TaskListTableViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
import UIKit
import FirebaseDatabase

//Nicolas Manzini from stack
extension String {
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
}

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
                    let taskDict = (value as! [String : Any]) //["completed": false, "name": hi, "important": false]
                    let name = key //this is the idNumber
                    let important = value //this is {completed = false;important = false;name = hi;}
                    
                    //taskDict["completed"] prints Optional(false)
                    let checkCompleted = taskDict["completed"] as! String
                    
                    if checkCompleted == "false"{
                        //if checkCompleted is false then add it to the array that will be used to show up on this page
                        let id = key
                        let important = taskDict["important"]
                        let name = taskDict["name"]
                        let completed = taskDict["completed"]

                        // Append new task to result Array
                        self.tasks.append(Task(
                            idCounter: id as! String,
                            name: name as! String,
                            important: important as! String,
                            completed: important as! String
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
        //this is a dummy name value to initialize (nothing will have this name)
        var uniqueName: Set = ["blobfish5000000xr"]
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                //it's a new one!
                uniqueTasks.append(thing) //add to uniqueTasks
                uniqueName.insert(thing.name) //add it in
            }
        }
        return uniqueTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        //DISTINCT ARRAAYYYAYAYAYAYA to fix doubling issue
        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                //it's a new one!
                uniqueTasks.append(thing) //add to uniqueTasks
                uniqueName.insert(thing.name) //add it in
            }
        }

        let task = uniqueTasks[indexPath.row]
        
        //cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        if task.important == "true" {
            cell.textLabel?.text = "* " + task.name + " *"
        }
        else{
            cell.textLabel?.text = " " + task.name
        }
        //tableView.reloadData()
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //DISTINCT ARRAAYYYAYAYAYAYA to fix doubling issue
        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
            if !uniqueName.contains(thing.name) {
                //it's a new one!
                uniqueTasks.append(thing) //add to uniqueTasks
                uniqueName.insert(thing.name) //add it in
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "isCompletedSegue",
            let destination = segue.destination as? TaskCompletedViewController,
            let index = tableView.indexPathForSelectedRow?.row {
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
