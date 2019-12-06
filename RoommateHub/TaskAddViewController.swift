//
//  TaskAddViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/6/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
//Youtube Sergey Kargopolov

import UIKit

class TaskAddViewController: UIViewController {
    
    var prevVC = TaskListTableViewController()//reference to previous view controller
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var importantLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let task = Task()
        task.name = titleTextField.text!
        task.important = importantSwitch.isOn
        
        prevVC.tasks.append(task)
        prevVC.tableView.reloadData() //update tableView
        
        navigationController?.popViewController(animated: true)

    }
}
