//
//  BaseViewController.swift
//  
//  Created by Finoit Technologies, Inc. 
//  Copyright  Finoit Technologies, Inc.. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem?) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backToRootAction(_ sender: UIBarButtonItem?) {
       
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
      
        self.dismiss(animated: true, completion: nil)
    }

}
