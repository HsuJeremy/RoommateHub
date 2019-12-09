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

            //let ref = Database.database().reference()
            ref.child(roomIdentifier!).child("taskList").observe(.value, with: { (snapshot) in
                // Get NSDictionary of user tasks
                let taskProfiles = snapshot.value as? NSDictionary
                print(taskProfiles)

                // Unwrap roommateProfiles
                guard let tasks = taskProfiles else { return }

                // Iterate through NSDictionary
                //tasks holds everything
                for (key, value) in tasks {
                    // Cast task as a Swift Dictionary
                    let taskDict = (value as! [String : Any])
                    print("print dict below") //["completed": false, "name": hi, "important": false]
                    print(taskDict)
                    let name = key //this is the idNumber
                    let important = value //this is {completed = false;important = false;name = hi;}
                    
                    print(taskDict["completed"]) //Optional(false)
                    let checkCompleted = taskDict["completed"] as! String
                    
                    if checkCompleted == "true"{
                        //if checkCompleted is false then add it to the array that will be used to show up on this page
                        print("it's true sooooo")
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
                        print(tasks) //tasks hold eEVerythignngngn

                    }

                    print(name)
                    print(important)
                    print(tasks)

                    self.tableView.reloadData()
                }
            })
            { (error) in
                print(error.localizedDescription)
            }

        print("below is tasks from VDL")
        print(tasks)
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        print("tableview num")
    //        print(tasks.count)
    //        print("tableview num end")
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

        
        print("below is tasks")
        print(uniqueTasks)
        let task = uniqueTasks[indexPath.row]
        print("tableView")
        print("below is indexPath.row task")
        print(indexPath.row)
        print(task)
        
        

        //cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        if task.important == "true" {
            cell.textLabel?.text = "* " + task.name + " *"
        }
        else{
            cell.textLabel?.text = " " + task.name
        }
        print("tableView end")
        //tableView.reloadData()

        return cell
    }
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //DISTINCT ARRAAYYYAYAYAYAYA to fix doubling issue
//        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
//        var uniqueTasks : [Task] = []
//        for thing in tasks{
//            if !uniqueName.contains(thing.name) {
//                //it's a new one!
//                uniqueTasks.append(thing) //add to uniqueTasks
//                uniqueName.insert(thing.name) //add it in
//            }
//        }
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if let addingVC = segue.destination as? CompletedTaskListTableViewController {
//            addingVC.prevVC = self
//        }
//        if segue.identifier == "isCompleted",
//            let destination = segue.destination as? TaskCompletedViewController,
//            let index = tableView.indexPathForSelectedRow?.row {
//            print("isCompleted shenenigans start here")
//            print(String(index))
//            print(uniqueTasks[index])
//                destination.task = uniqueTasks[index]
//                destination.roomIdentifier = roomIdentifier
//            print("isCompleted shenenigans end here")
//
//            }
//        else if segue.identifier == "AddTaskSegue", let destination = segue.destination as? TaskAddViewController {
//            //print("Performed segue")
//            destination.roomIdentifier = roomIdentifier
//            let counter = Date().timer()
//            print(counter!)
//            destination.counter = counter!
//
//        }
//
//
//    }


}

