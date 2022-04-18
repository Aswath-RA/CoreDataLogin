//
//  ViewController.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SignUpButton.ToRound()
        LoginButton.ToRound()
    }


}

