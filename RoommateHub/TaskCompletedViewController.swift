//
//  TaskCompletedViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/6/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TaskCompletedViewController: UIViewController {
    
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    let ref = Database.database().reference()
    
    var roomIdentifier: String? = nil
    var task: Task? = nil

    //var prevVC = TaskListTableViewController()//reference to previous view controller

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = task!.name
    }
    
    
    @IBAction func completedClicked(_ sender: Any) {
        //let task = Task()
        print("below is from the completeclicked (task)")
        print(task)
        print("completeclicked done")
        ref.child(self.roomIdentifier!).child("taskList").child(task!.idCounter).setValue(["completed": "true", "important": task!.important, "name": task!.name,])

        completedButton.isHidden = true
        //prevVC.tasks.append(task!)
        //prevVC.tableView.reloadData() //update tableView
        
        //navigationController?.popViewController(animated: true)

    }
}
