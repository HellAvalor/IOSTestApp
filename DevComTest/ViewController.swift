//
//  ViewController.swift
//  DevComTest
//
//  Created by Yuliya Karaman on 4/3/15.
//  Copyright (c) 2015 Andrew Karaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    var requestText: String = ""
    var md5: String = ""
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func requestButton(sender: AnyObject) {
            println("test")
        
        loadingIndicator.hidden = false
        let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("view2") as SecondViewController
        
        self.navigationController?.pushViewController(view2, animated: false)

        var url : String = "http://md5.jsontest.com/?text=" + inputField.text
        
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {(response:NSURLResponse!, data: NSData!, error: NSError!)-> Void in
        
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil)
            {
                println("test222")
//                self.md5 = jsonResult.debugDescription
               view2.md5Label.text = jsonResult.debugDescription
            } else {
            
            }
        
        })
        

        
    }

}

