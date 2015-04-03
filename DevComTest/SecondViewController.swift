//
//  SecondViewController.swift
//  DevComTest
//
//  Created by Yuliya Karaman on 4/3/15.
//  Copyright (c) 2015 Andrew Karaman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var requestText: String = ""
    var md5: String = ""
    
    @IBOutlet weak var requestTextLabel: UILabel!
    
    @IBOutlet weak var md5Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTextLabel.text = "Request: " + requestText
        md5Label.text = "MD5: " + md5
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}