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
    
    var roomIdentifier: String? = nil
    var task: Task? = nil

    var prevVC = TaskListTableViewController()//reference to previous view controller

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func completedClicked(_ sender: Any) {
        let task = Task()
        
        prevVC.tasks.append(task)
        prevVC.tableView.reloadData() //update tableView
        
        navigationController?.popViewController(animated: true)

    }
}
