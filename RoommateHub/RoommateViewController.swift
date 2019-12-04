//
//  RoommateViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
// Repurposed from NoteViewController.swift from Notes app

import UIKit

class RoommateViewController: UIViewController {
    var roommate: Roommate? = nil
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var concentrationLabel: UILabel!
    @IBOutlet weak var gradYearLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullNameLabel.text = roommate!.firstName + " " + roommate!.lastName
        usernameLabel.text = roommate!.username
        hometownLabel.text = roommate!.hometown
        concentrationLabel.text = roommate!.concentration
        gradYearLabel.text = String(roommate!.year)
        ageLabel.text = String(roommate!.age)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
