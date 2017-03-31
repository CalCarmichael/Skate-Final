//
//  FeedViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 31/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    var databaseReference: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

    databaseReference = FIRDatabase.database().reference()
        
        if let currentUserID = FIRAuth.auth()?.currentUser?.uid {
            print(currentUserID)
            
            getUsersImFollowing()
            
        } else {
            
            print("Not Logged In")
        }
        
        
    }

    func getUsersImFollowing() {
        
        let userID = "Me" //substitute of currentuserID
        let followReference = databaseReference.child("Follow").child(userID).child("Following")
        followReference.observeSingleEvent(of: .value, with: { (FollowingSnapshot) in
            let FollowingDictionary = FollowingSnapshot.value as? NSDictionary
            print(FollowingDictionary?.count ?? 0)
            self.getUsersImFollowingInformation(dict: FollowingDictionary as! [String: String])
            
        }) { (error) in
            print(error)
        }
        
    }
    
    func getUsersImFollowingInformation(dict: [String:String]) {
        
        //Loop through dictionary
        
        for(userID, userName) in dict {
        
            let profileReference = databaseReference.child("User").child(userID)
            profileReference.observeSingleEvent(of: .value, with: { (ProfileSnapshot) in
                let userDictionary = ProfileSnapshot.value as? NSDictionary
                let profilePictureUrl = userDictionary?["profile_photo"] as? String ?? "unknown user"
                
                let photosReference = self.databaseReference.child("Photo").child(userID)
                
                photosReference.observe(.value, with: { (photoPostSnapshot) in
                    let photoPostsDictionary = photoPostSnapshot.value as? NSDictionary
                    for(id, post) in photoPostsDictionary! {
                        print(userName)
                        print(profilePictureUrl)
                        print(id, post)
                        
                    }
                    
                }, withCancel: { (error) in
                    print(error)
                    
                })
                
                
            }, withCancel: { (error) in
                print(error)
            })
            
    }

}

}
