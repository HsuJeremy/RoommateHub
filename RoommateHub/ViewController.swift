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

class ViewController: UIViewController {
    
    var homePageList: [String] = []
    
    
    @IBOutlet var hpTitle: UILabel! //hp stands for homepage
    @IBOutlet var hpRoommate: UIButton!
    @IBOutlet var hpHouseKeeping: UIButton!
    @IBOutlet var hpMessageBoard: UIButton!
    @IBOutlet var hpContract: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hpTitle.text = "Roommate Hub"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }



}

