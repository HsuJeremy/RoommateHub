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

class HomeViewController: UIViewController {
    
    var homePageList: [String] = []
//
    @IBOutlet var hpTitle: UILabel! //hp stands for homepage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hpTitle.text = "RoommateHub"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

