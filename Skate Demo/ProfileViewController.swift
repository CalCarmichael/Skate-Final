//
//  ProfileViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 29/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameText: UILabel!
    @IBOutlet weak var bioText: UITextView!
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        databaseRef = FIRDatabase.database().reference()
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            databaseRef.child("Profile").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                let dictionary = snapshot.value as? NSDictionary
                
                //Username and default username
                
                let username = dictionary?["username"] as? String ?? "username"
                
                //Display name
                
                let display = dictionary?["display"] as? String ?? "display"
                
                //Bio
                
                let bio = dictionary?["bio"] as? String ?? "bio"
                
                //Profile Image
                
                if let profileImageURL = dictionary?["photo"] as? String {
                    
                    let url = URL(string: profileImageURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                        print(error!)
                        return
                            
                        }
                                DispatchQueue.main.async {
                                    self.profileImageView.image = UIImage(data: data!)
                                }
                        
                    }).resume()
                    
                }
                
                self.usernameText.text = username
                self.displayNameText.text = display
                self.bioText.text = bio
            
            }) { (error) in
                
                print(error.localizedDescription)
                return
            
        }
    
    }

}

}
