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
    
    
//    override func viewDidLoad() {
//        tasksInCompleted.removeAll()
//        self.tableView.reloadData()
//
//        // From Code with Chris on YouTube
//        //this adds all the created (ALL the data period, actually) to the master list of all the tasks (next step is sorting them by completed and incomplete children)
//        let ref = Database.database().reference()
//        print("viewDL start")
//        print(counter)
//        ref.child(roomIdentifier!).child("taskList").observe(.childAdded) { (snapshot) in
//            print("below is message")
//            let message = snapshot.value as? String
//            print(message)
//            guard let actualMessage = message else { return }
//            print("below is actualMessage")
//            print(actualMessage)
//            print("below is tasksInCompleted")
//            print(self.tasksInCompleted)
//            self.tasksInCompleted.append(actualMessage)
//            print("below is tasksInCompleted")
//            print(self.tasksInCompleted)
//            print("viewDL end")
//            self.tableView.reloadData()
//        }
//
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//
////            if !snapshot.exists() { return }
////
////            print(snapshot)
////
////            if let userName = snapshot.value!["completed"] as? String {
////                print(userName)
////            }
////            if let email = snapshot.value["email"] as? String {
////                print(email)
////            }
//
//            // can also use
////            print(snapshot.childSnapshot(forPath: "completed").value as! String)
//        })
//
//    }
    
//
//        override func viewDidLoad() {
//            // From Code with Chris on YouTube
//            let ref = Database.database().reference()
//            ref.child(roomIdentifier!).child("taskList").observe(.childAdded) { (snapshot) in
//                print("View did load \(snapshot.value)")
//            //let message = snapshot.value as? String
//    //            guard let actualMessage = message else { return }
//    //            self.tasks.append(actualMessage)
//    //            self.tableView.reloadData()
//            }
//        }
    
//    func distinceReturn(tascks:[Task] ) -> [Task].Type {
//        var seen = Set<String>()
//        var unique = [Task].self
//        for message in tascks {
//            if !seen.contains(message.idCounter) {
//                unique.append(message)
//                seen.insert(message.idCounter)
//            }
//        }
//        return unique
//
//    }

    
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
                    
                    if checkCompleted == "false"{
                        //if checkCompleted is false then add it to the array that will be used to show up on this page
                        print("it's false sooooo")
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
                if !uniqueName.contains(thing.name) {
                    //it's a new one!
                    uniqueTasks.append(thing) //add to uniqueTasks
                    uniqueName.insert(thing.name) //add it in
                }
            }
            return uniqueTasks.count
        }
        

/*    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        // Configure the cell...
        let task = tasks[indexPath.row]
        print("tableView")
        print(task)
        
        if task.important == "true" {
            cell.textLabel?.text = "* " + tasksString[indexPath.row] + " *"
        }
        else{
            cell.textLabel?.text = " " + tasksString[indexPath.row]
        }
        print("tableViewEnd")
        return cell
    }
*/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        //DISTINCT ARRAAYYYAYAYAYAYA
        var uniqueName: Set = ["blobfish5000000xr"] //this is a dummy name value to initialize (nothing will have this name)
        var uniqueTasks : [Task] = []
        for thing in tasks{
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
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
//        cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
//        cell.textLabel?.text = messages[indexPath.row]
//        return cell
//    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let addingVC = segue.destination as? TaskAddViewController {
            addingVC.prevVC = self
        }
        if segue.identifier == "isCompleted",
            let destination = segue.destination as? TaskCompletedViewController,
            let index = tableView.indexPathForSelectedRow?.row {
                destination.taskString = tasksInCompleted[index]
                destination.roomIdentifier = roomIdentifier
                //destination.counter = Date().timer()
            }
        else if segue.identifier == "AddTaskSegue", let destination = segue.destination as? TaskAddViewController {
            //print("Performed segue")
            destination.roomIdentifier = roomIdentifier
            let counter = Date().timer()
            print(counter!)
            destination.counter = counter!

        }

        
    }


}

