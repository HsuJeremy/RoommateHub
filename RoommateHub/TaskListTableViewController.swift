//
//  TaskListTableViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    var tasks : [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = createTask()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    func createTask() -> [Task] {
        
        let milk = Task()
        milk.name = "get milk"
        milk.important = true
        let clean = Task()
        clean.name = "clean room"
        let cat = Task()
        cat.name = "feed cat"

        return [milk, clean, cat]
    }
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        // Configure the cell...
        let task = tasks[indexPath.row]
        //cell.textLabel?.text = task.name
        
        if task.important {
            cell.textLabel?.text = "* " + task.name + " *"
        }
        else{
            cell.textLabel?.text = " " + task.name
        }
        
        //print("fill in works")

        return cell
    }
    
    
/*    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "isCompleted", sender: task)
    }
 */
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let addingVC = segue.destination as! TaskAddViewController
        addingVC.prevVC = self
    }
    

}
