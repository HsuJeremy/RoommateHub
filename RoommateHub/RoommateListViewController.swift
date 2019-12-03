//
//  RoommateListViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
//  Repurposed NotesListViewController.swift from Notes app

import UIKit

class RoommateListViewController: UITableViewController {
    var roommates: [Roommate] = []
    
    func reload() {
        roommates = RoommateManager.shared.getRoommates()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoommateManager.shared.clear()
        RoommateManager.shared.fillDummyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roommates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoommateCell", for: indexPath)
        cell.textLabel?.text = roommates[indexPath.row].firstName + roommates[indexPath.row].middleName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoommateSegue",
                let destination = segue.destination as? RoommateViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.roommate = roommates[index]
        }
    }
}

