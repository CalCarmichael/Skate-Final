//
//  CameraViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 30/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var captionTextView: UIView!
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func takePhotoAction(_ sender: Any) {
    }
    
    @IBAction func uploadPhotoLibrary(_ sender: Any) {
        
        getPhotoFromLibrary()
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
    
    }

    @IBAction func postPhoto(_ sender: Any) {
    
        takePhoto()
    
    }

    //Photo from library
    
    func getPhotoFromLibrary() {
     
        picker.delegate = self
        picker.allowsEditing = false
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
        
    }
    
    //Camera take photo
    
    func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
        
    } else {
    
            noCameraAvailable()
    
        }
        
    }
    
    //Alert to say user has no camera
    
    func noCameraAvailable () {
        
        let alertVC = UIAlertController(title: "No Camera Available", message: "Cant find a camera on this device", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true, completion: nil)
        
    }

    //Image picker function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageViewPost.image = chosenImage
        dismiss(animated: true, completion: nil)
        
        
    }
    
    //Cancels the controller
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }


}
