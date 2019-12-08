//
//  TaskAddViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/6/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
//Youtube Sergey Kargopolov

import UIKit
import FirebaseDatabase

class TaskAddViewController: UIViewController {
    
    var prevVC = TaskListTableViewController()//reference to previous view controller
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var importantLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    @IBOutlet weak var addButton: UIButton!
    
    var roomIdentifier: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let ref = Database.database().reference()
        
        let task = Task()
        task.name = titleTextField.text!
        if importantSwitch.isOn{
            task.important = "true"
        }
        print(self.roomIdentifier)
        print(task.important)
        print(task.name)
        
        ref.child(self.roomIdentifier!).child("taskList").child(task.name).setValue(task.important)
        
        prevVC.tasks.append(task)
        prevVC.tableView.reloadData() //update tableView
        
        navigationController?.popViewController(animated: true)

    }

}
