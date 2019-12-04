//
//  HouseKeepingViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 11/28/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation

import UIKit

class HouseKeepingViewController: UIViewController {
    @IBOutlet var houseKeepingTitle: UILabel!


   /* var tasks: [HouseKeepingTask] = []
    
    @IBAction func createHouseKeepingTask() {
        let _ = HouseKeepingTaskManager.shared.create()
        reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    //reloads tableview
    func reload() {
        tasks = HouseKeepingTaskManager.shared.getHouseKeepingTasks() //give all the tasks that are currently in the database
        tableView.reloadData() //reload data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseKeepingTaskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HouseKeepingTaskSegue",
                let destination = segue.destination as? HouseKeepingTaskViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.task = tasks[index]
        }
    }*/
}
