//
//  ViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 11/27/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

//this view controller is for the HOMEPAGE and just directs you to all the other storyboards
//to do: segues lol

import UIKit
import Firebase

class HomeViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hpTitle.text = "RoommateHub"
        print(roomIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

