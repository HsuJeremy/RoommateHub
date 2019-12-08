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
        // Configure UITextField delegates and tap gestures
        configureTapGesture()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let ref = Database.database().reference()
        
        var task = Task()
        task.name = titleTextField.text!
        if importantSwitch.isOn{
            task.important = "true"
        }        
        
        ref.child(self.roomIdentifier!).child("taskList").child("notCompleted").child(task.name).setValue(task.important)
            
        
        prevVC.tasks.append(task)
        prevVC.tableView.reloadData() //update tableView
        
        navigationController?.popViewController(animated: true)

    }
    
    
    // From Code Pro on YouTube
    private func configureTapGesture() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TaskAddViewController.handleTap))
       view.addGestureRecognizer(tapGesture)
    }

    // From Code Pro on YouTube
    @objc func handleTap() {
       print("Handle tap was called")
       view.endEditing(true)
    }


}
