//
//  CameraViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 04/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class CameraViewController: UIViewController {
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCameraPhoto))
        cameraImage.addGestureRecognizer(tapGesture)
        cameraImage.isUserInteractionEnabled = true
        
        
        
    }
    
    //Getting photo
    
    func handleCameraPhoto() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    //Sharing photo
    
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
        
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            
            //Creating ID for photos users post
            
            let photoIdString = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoIdString)
            
            storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                    
                }
                
                //Send data to database
                
                let photoUrl = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl!)
                
                
            })
            
            
        } else {
            
            ProgressHUD.showError("Profile Image must be chosen")
            
            
        }
        
        
        
    }
    
    //Send data to database with unqiue post id
    
    func sendDataToDatabase(photoUrl: String) {
        
        let ref = FIRDatabase.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId)
        newPostReference.setValue(["photoUrl": photoUrl], withCompletionBlock: {
            (error, ref) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            ProgressHUD.showSuccess("Success")
            
        })
    
    }
    
}

//Getting photo with image picker

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("did finish pick")
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            cameraImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
