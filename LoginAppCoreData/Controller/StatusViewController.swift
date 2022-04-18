//
//  StatusViewController.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import UIKit

class StatusViewController: UIViewController {
    
    var userName = ""

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userNameLabel.text = "Hi \(userName)"
        
        self.present(CustomAlert.alertMessage("SuccessFully Logged In ","Thank You For Using Apple Market"), animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    
   
    
   

}
