//
//  TaskAddViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/6/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
// Youtube Sergey Kargopolov

import UIKit
import FirebaseDatabase

class TaskAddViewController: UIViewController {
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
    let roomReference = Database.database().reference().child(self.roomIdentifier!)
    var task = Task()
    task.name = titleTextField.text!
    if importantSwitch.isOn {
      task.important = "true"
    }
    let taskData: [String : Any] = [
      "name": task.name,
      "important": task.important,
      "completed": task.completed,
    ]
    roomReference.child("taskList").child(String(counter!)).setValue(taskData)
    navigationController?.popViewController(animated: true)
  }
  
  // From Code Pro on YouTube
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(TaskAddViewController.handleTap)
    )
    view.addGestureRecognizer(tapGesture)
  }

  // From Code Pro on YouTube
  @objc func handleTap() {
    print("Handle tap was called")
    view.endEditing(true)
  }
}
