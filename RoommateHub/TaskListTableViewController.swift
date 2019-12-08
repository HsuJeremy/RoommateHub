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
    
    var tasksCompleted: [String] = []
    var tasks : [Task] = []
    var roomIdentifier: String? = nil
    var counter: String? = "1010"
    var database = Database.database();
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        tasksCompleted.removeAll()
        self.tableView.reloadData()

        // From Code with Chris on YouTube
        let ref = Database.database().reference()
        print("viewDL start")
        print(counter)
        ref.child(roomIdentifier!).child("taskList").child(counter!).observe(.childAdded) { (snapshot) in
            let message = snapshot.value as? String
            print(message)
            guard let actualMessage = message else { return }
            print(actualMessage)
            print(self.tasksCompleted)
            self.tasksCompleted.append(actualMessage)
            print(self.tasksCompleted)
            print("viewDL end")
            self.tableView.reloadData()
        }
    }
    
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

    
//    override func viewDidLoad() {
//
//            //let ref = Database.database().reference()
//            ref.child(roomIdentifier!).child("taskList").observe(.value, with: { (snapshot) in
//                // Get NSDictionary of user tasks
//                let taskProfiles = snapshot.value as? NSDictionary
//                print(taskProfiles)
//
//                // Unwrap roommateProfiles
//                guard let tasks = taskProfiles else { return }
//
//                // Iterate through NSDictionary
//                for (key, value) in tasks {
//                    // Cast task as a Swift Dictionary
//                    let taskDict = (value as! [String : Any])
//                    print("print dict below")
//                    print(taskDict)
//
//                    // Unwrap each property of task
//                    //guard let name = taskDict["name"] else { return }
//                    //guard let important = taskDict["important"] else { return }
//                    for(theKey, theValue) in taskDict{
//                        let name = theKey
//                        let important = theValue
//
//                        // Append new Roommate to result Array
//                        self.tasks.append(Task(
//                            name: name as! String,
//                            important: important as! String,
//                            completed: important as! String
//                        ))
//                    }
//                    self.tableView.reloadData()
//
//                }
//            })
//            { (error) in
//                print(error.localizedDescription)
//            }
//        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        print("tableview num")
    //        print(tasks.count)
    //        print("tableview num end")

            return tasksCompleted.count
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
        let task = tasksCompleted[indexPath.row]
//        print("tableView")
//        print(task)

//        cell.textLabel!.font = UIFont(name: "SF Pro Display", size: 18)
//        if task.important == "true" {
//            cell.textLabel?.text = "* " + task.name + " *"
//        }
//        else{
//            cell.textLabel?.text = " " + task.name
//        }
//        print("tableView end")
        tableView.reloadData()



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
                destination.taskString = tasksCompleted[index]
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

