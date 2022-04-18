//
//  SignUpViewController.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField : UITextField!
    @IBOutlet weak var LastNameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    var email = ""
    var password = ""
    var firstname = ""
    var lastname = ""
    
    
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpButton.ToRound()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        
        let (error_title,error_text) = validateTextFields()
        
        if  error_title != nil && error_text != nil {
            showError(error_title!,error_text!)
        }
        
        firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        lastname = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: manageContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: manageContext)
        
        user.setValue(firstname, forKey: "firstname")
        user.setValue(lastname, forKey: "lastname")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        
        do{
            try manageContext.save()
            print("Value Saved")
            
            self.showError("Sucessfully Signed Up", "Go to Login and try ..")
            self.toClearAll()
            
            
        }
        
        catch{
            self.showError("Try Again", "Try with another email and password")
        }
      
    }
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            
            return ("Empty Fields","Please Enter in all Fields")
        }
        return (nil,nil)
    }
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
        
    }
    
    func toClearAll () {
        firstNameTextField.text = ""
        LastNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
}
