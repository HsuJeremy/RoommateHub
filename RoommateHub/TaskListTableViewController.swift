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
            // Get NSDictionary of user profiles
            let roommateProfiles = snapshot.value as? NSDictionary
            
            // Unwrap roommateProfiles
            guard let profiles = roommateProfiles else { return }
            
            // Iterate through NSDictionary
            for (key, value) in profiles {
                // Cast profile as a Swift Dictionary
                let profileDict = (value as! [String : Any])
                print(profileDict)
                
                // Unwrap each property of profile
                guard let name = profileDict["name"] else { return }
                guard let important = profileDict["important"] else { return }
                                
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

class TaskListTableViewController: UITableViewController {
    
    
    var tasks : [Task] = []
    var database = Database.database();
    var roomIdentifier: String? = nil
    let ref = Database.database().reference()



    override func viewDidLoad() {
        super.viewDidLoad()
        //let ref = Database.database().reference() //pointer to database
        /*
        database().ref("Task").set({
          name: name,
          important: important
        });
        */
        //tasks = createTask()
        /*let ref = Database.database().reference()
        ref.child(roomIdentifier!).child("taskList").observe(.childAdded) { (snapshot) in
            let task = snapshot.value as? String
            guard let actualTask = task else { return }
            self.tasks.append(actualTask)
            self.tableView.reloadData()
        }*/

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        // Configure the cell...
        let task = tasks[indexPath.row]
        
        if task.important == "true" {
            cell.textLabel?.text = "* " + task.name + " *"
        }
        else{
            cell.textLabel?.text = " " + task.name
        }
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
            print("Performed segue")
            destination.roomIdentifier = roomIdentifier
        }

        
    }
    


}

