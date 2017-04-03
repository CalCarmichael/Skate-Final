//
//  SignUpViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 03/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Editing the text fields UI
        
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLineUsername = CALayer()
        bottomLineUsername.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLineUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLineUsername)
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLineEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLineEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLinePassword = CALayer()
        bottomLinePassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLinePassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLinePassword)
        
        //Profile image UI - Half of rectangle in size inspector
        
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        
    }
    
    @IBAction func dismissOnClick(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
    }

    @IBAction func signUpButton_TouchUpInside(_ sender: Any) {
    
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            let ref = FIRDatabase.database().reference()
            let userReference = ref.child("users")
            let uid = user?.uid
            let newUserReference = userReference.child(uid!)
            newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
            print("description: \(newUserReference.description())")
            
            
            
        })
    
    
    }
    
  

}
