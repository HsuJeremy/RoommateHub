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
    var counter: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure UITextField delegates and tap gestures
        configureTapGesture()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let ref = Database.database().reference()
        print("addClick Start")
        var task = Task()
        task.name = titleTextField.text!
        if importantSwitch.isOn{
            task.important = "true"
        }
        let taskData: [String : Any] = [
            "name": task.name,
            "important": task.important,
            "completed": task.completed,
        ]
        print("addClick middle")

        ref.child(self.roomIdentifier!).child("taskList").child(String(counter!)).setValue(taskData)
        print("below is id")
        print(String(counter!))
        print(taskData)
        print("above is taskData")
        
        //prevVC.tasks.append(task)
        //prevVC.tableView.reloadData() //update tableView
        
        navigationController?.popViewController(animated: true)
        print("addClick ended")

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
