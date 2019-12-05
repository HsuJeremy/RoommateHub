//
//  RoommateListViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
//  Repurposed NotesListViewController.swift from Notes app

import UIKit
import FirebaseDatabase

//class RoommateListViewController: UITableViewController {
//    var roommates: [Roommate] = []
//    var roomIdentifier: String? = nil
//
//    func reload() {
//        // roommates = RoommateManager.shared.getRoommates()
//        tableView.reloadData()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        RoommateManager.shared.clear()
////        RoommateManager.shared.fillDummyData()
//
////        let ref = Database.database().reference()
////
////        ref.child("-LvIRWRC06uvJx-z132Q").observeSingleEvent(of: .value, with: { (snapshot) in
////            // Get user value
////            let value = snapshot.value as? NSDictionary
////            print("It works!")
////            print(value)
////        }) { (error) in
////            print(error.localizedDescription)
////        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        reload()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return roommates.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RoommateCell", for: indexPath)
//        cell.textLabel?.text = roommates[indexPath.row].firstName + " " + roommates[indexPath.row].lastName
//        return cell
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "RoommateSegue",
//                let destination = segue.destination as? RoommateViewController,
//                let index = tableView.indexPathForSelectedRow?.row {
//            destination.roommate = roommates[index]
//        }
//    }
//}
//

class RoommateListViewController: UITableViewController {
    var roommates: [Roommate] = []
    var roomIdentifier: String? = nil
    
    @IBAction func test(_ sender: Any) {
        print(self.roommates)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roommates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoommateCell", for: indexPath)
        cell.textLabel?.text = roommates[indexPath.row].firstName
        return cell
    }
    
    override func viewDidLoad() {
        let ref = Database.database().reference()
        
        print(roomIdentifier!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        ref.child(roomIdentifier!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get NSDictionary of user profiles
//            let roommateProfiles = snapshot.value as? NSDictionary
//
//            print(roommateProfiles)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        ref.child(roomIdentifier!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get NSDictionary of user profiles
                    let roommateProfiles = snapshot.value as? NSDictionary
                    
                    // Unwrap roommateProfiles
                    guard let profiles = roommateProfiles else { return }
                    
                    // Iterate through NSDictionary
                    for (key, value) in profiles {
                        // Cast profile as a Swift Dictionary
                        let profileDict = (value as! [String : Any])
                        print(profileDict)
                        
                        // Unwrap each property of profile
                        guard let firstName = profileDict["firstName"] else { return }
                        guard let lastName = profileDict["lastName"] else { return }
                        guard let hometown = profileDict["hometown"] else { return }
                        guard let concentration = profileDict["concetration"] else { return }
                        guard let gradYear = profileDict["gradYear"] else { return }
                        guard let age = profileDict["age"] else { return }
                        guard let cellPhoneNumber = profileDict["cellPhoneNumber"] else { return }
                        
                        // Append new Roommate to result Array
                        self.roommates.append(Roommate(
                            firstName: firstName as! String,
                            lastName: lastName as! String,
                            hometown: hometown as! String,
                            concentration: concentration as! String,
                            gradYear: gradYear as! Int,
                            age: age as! Int,
                            cellPhoneNumber: cellPhoneNumber as! Int
                        ))
                        self.tableView.reloadData()
                        print(self.roommates)
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
    }
}
