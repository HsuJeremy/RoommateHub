//
//  ViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 11/27/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

//this view controller is for the HOMEPAGE and just directs you to all the other storyboards

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {
    var house: String? = nil  
    var roomNumber: String? = nil
    var email: String? = nil
    var roomIdentifier: String? = nil
    
    @IBAction func logOutAction(_ sender: Any) {
        // From official Firebase documentation
        do {
            try Auth.auth().signOut()
            print("Logged out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // From Ashika Kasiviswanathan on Medium.com
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    var homePageList: [String] = []
//
    @IBOutlet var hpTitle: UILabel! //hp stands for homepage
    @IBOutlet weak var currentUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomIdentifier = house! + roomNumber!
        
        // Display room number
        hpTitle.text = house!.capitalized + " " + roomNumber!.capitalized
        
        // Fetch full name from database
        let ref = Database.database().reference()
        ref.child(roomIdentifier!).child("users").child(email!.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")).observe(.value, with: { (snapshot) in
            // Get NSDictionary of user profiles
            let profileData = snapshot.value as! [String : Any]
            guard let firstName = profileData["firstName"] else { return }
            guard let lastName = profileData["lastName"] else { return }
            
            self.currentUser.text = "\(firstName as! String) \(lastName as! String)"
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToRoommateList", let destination = segue.destination as? RoommateListViewController {
            destination.roomIdentifier = roomIdentifier
        }
        else if segue.identifier == "homeToMessageList", let destination = segue.destination as? MessagesListViewController {
            destination.roomIdentifier = roomIdentifier
        }
        else if segue.identifier == "homeToTaskList", let destination = segue.destination as? TaskListTableViewController {
            destination.roomIdentifier = roomIdentifier
        }
    }
}

