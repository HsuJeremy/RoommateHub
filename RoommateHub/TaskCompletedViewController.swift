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

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = task!.name
    }
    
    @IBAction func completedClicked(_ sender: Any) {
        if task!.important == "true"{
            ref.child(self.roomIdentifier!).child("taskList").child(task!.idCounter).setValue(["completed": "true", "important": task!.important, "name": task!.name + " ❗️",])
        }
        else{
            ref.child(self.roomIdentifier!).child("taskList").child(task!.idCounter).setValue(["completed": "true", "important": task!.important, "name": task!.name,])
        }
        completedButton.isHidden = true
    }
}
