//
//  TaskListTableViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
/*
import UIKit
import FirebaseDatabase

class TaskListTableViewController: UITableViewController {
    
    var tasks : [Task] = []
    var roomIdentifier: String? = nil

    override func viewDidLoad() {
        tasks = createTask()
        
        let ref = Database.database().reference()
        
        ref.child(roomIdentifier!).child("tasks").observe(.value, with: { (snapshot) in
            // Get NSDictionary of user tasks
            let roommateProfiles = snapshot.value as? NSDictionary
            
            // Unwrap roommateProfiles
            guard let tasks = roommateProfiles else { return }
            
            // Iterate through NSDictionary
            for (key, value) in tasks {
                // Cast task as a Swift Dictionary
                let taskDict = (value as! [String : Any])
                print(taskDict)
                
                // Unwrap each property of task
                guard let name = taskDict["name"] else { return }
                guard let important = taskDict["important"] else { return }
                                
                // Append new Roommate to result Array
                self.tasks.append(Task(
                    name: name as! String,
                    important: important as! String
                ))
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
*/
import UIKit
import FirebaseDatabase

//Nicolas Manzini from stack
extension String {
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
}

class TaskListTableViewController: UITableViewController {
    
    var tasksString: [String] = []
    var tasks : [Task] = []
    var roomIdentifier: String? = nil
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
            for (key, value) in tasks {
                // Cast task as a Swift Dictionary
                let taskDict = (value as! [String : Any])
                print("print dict below")
                print(taskDict)
                
                // Unwrap each property of task
                guard let name = taskDict["name"] else { return }
                guard let important = taskDict["important"] else { return }
                print("viewdidloadd")
                print(name)
                print(important)
                print("viewdidloaddEND")

                // Append new Roommate to result Array
                self.tasks.append(Task(
                    name: name as! String,
                    important: important as! String,
                    completed: important as! String
                ))
                self.tableView.reloadData()
            }
        })
        // From Code with Chris on YouTube
//        ref.child(roomIdentifier!).child("taskList").child(" unCompleted").observe(.childAdded) { (snapshot) in
//            print("From view did load")
//            print(snapshot.value)
//            let task = snapshot.value as? [Bool : String]
//            guard let actualMessage = task else { return }
//            self.tasksString.append(actualMessage)
//            print(self.tasksString)
//            self.tableView.reloadData()
//        }
        { (error) in
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("tableview num")
//        print(tasks.count)
//        print("tableview num end")

        return tasks.count
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
        let task = tasks[indexPath.row]
//        print("tableView")
//        print(task)

        cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
        if task.important == "true" {
            cell.textLabel?.text = "* " + task.name + " *"
        }
        else{
            cell.textLabel?.text = " " + task.name
        }
//        print("tableView end")


        return cell
    }
    
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
                destination.task = tasks[index]
                destination.roomIdentifier = roomIdentifier
            }
        else if segue.identifier == "AddTaskSegue", let destination = segue.destination as? TaskAddViewController {
            //print("Performed segue")
            destination.roomIdentifier = roomIdentifier
        }

        
    }
    


}

