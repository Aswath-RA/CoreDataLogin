//
//  LoginViewController.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var PasswordTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    var email = ""
    var password = ""
    var firstname = ""
    var lastname = ""
    
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButton.ToRound()
        
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        
        let (error_title,error_text) = validateTextFields()
        
        if  error_title != nil && error_text != nil {
            showError(error_title!,error_text!)
        }
        
        email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = PasswordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchData.predicate = NSPredicate(format:"email = %@",email)
        fetchData.predicate = NSPredicate(format:"password = %@",password)
        
        do
        {
            let results = try manageContext.fetch(fetchData)
            
            if results.isEmpty
            {
                self.showError("Invalid Credentials", "If you don't have a account try to SignUp...")
            }
            
            for data in results as! [NSManagedObject]
            {
                firstname = data.value(forKey: "firstname") as! String
                lastname =  data.value(forKey: "lastname") as! String
                email = data.value(forKey: "email") as! String
                password =  data.value(forKey: "password") as! String
                
            }
            
            self.toStatusViewController(FirstName: firstname, LastName: lastname)
            self.toClearAll()
            
        }
        
        catch
        {
            self.showError("User Not Found", "Try to Sign Up")
        }
      
    }
    
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || PasswordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return ("Empty Fields","Please Enter in all Fields")
        }
        return (nil,nil)
    }
    
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
        
    }
    
    
    func toStatusViewController(FirstName : String ,LastName : String) {
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "StatusViewController") as! StatusViewController
        
        vc.userName = "\(firstname) \(lastname)"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func toClearAll () {
        
        emailTextField.text = ""
        PasswordTextFiled.text = ""
    }
    
}
