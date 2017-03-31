//
//  SignUpViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 29/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var databaseRef: FIRDatabaseReference!

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = FIRDatabase.database().reference()
        
        
    }
    
    //Creating user sign up

    func signUp(email: String, password: String) {
        
        FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
            
            if error != nil {
                print (error!)
                return
                
            } else {
                
               //Creating profile and sending to map
                
               self.createProfile(user!)
               self.performSegue(withIdentifier: "Signup", sender: nil)
                
                
            }
            
        })
        
    }
    
    //Creating user profile
    
    func createProfile(_ user: FIRUser) {
       
        let delimiter = "@"
        let email = user.email
        let userName = email?.components(separatedBy: delimiter)
        
        let newUser = User(bio: "", display: (userName?[0])!, email: email!, photo: "https://firebasestorage.googleapis.com/v0/b/skate-286c4.appspot.com/o/empty_profile_picture.jpg?alt=media&token=f09bfd51-a2b7-47b4-8e1f-fea23f791da0", username: (userName?[0])!)
        
        self.databaseRef.child("Profile").child(user.uid).updateChildValues(newUser.getUserAsDictionary()) { (error, ref) in
            if error != nil {
                print (error!)
                return
            }
            
            print ("Profile successfully completed")
            
        }
        
    }
    
    
    
    @IBAction func signupButtonAction(_ sender: Any) {
       
        
        guard let email = emailText.text, let password = passwordText.text else {return}
        signUp(email: email, password: password)
        
    }
    
}
