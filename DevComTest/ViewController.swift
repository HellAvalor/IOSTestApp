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
        
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()


        var url : String = "http://md5.jsontest.com/?text=" + inputField.text

        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {(response:NSURLResponse!, data: NSData!, error: NSError!)-> Void in
        
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil)
            {
                
                if let errorMessage = jsonResult.valueForKey("error") as? String {
                    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(),{ () -> () in
                        
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator.hidden = true
                        
                        let alert = UIAlertView()
                        alert.title = "Error"
                        alert.message = errorMessage
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                        
                    })
                    
                    return
                }
                
                dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(),{ () -> () in
                
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidden = true
                    let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("view2") as SecondViewController
                    view2.md5 = jsonResult.valueForKey("md5") as String
                    view2.requestText = jsonResult.valueForKey("original") as String
                    self.navigationController?.pushViewController(view2, animated: false)
                    
                })
                
            } else {
                dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(),{ () -> () in
                    
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidden = true
                    
                })

            }
        
        })
        

        
    }

}

