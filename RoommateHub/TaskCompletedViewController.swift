//
//  TaskCompletedViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/6/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit

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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
