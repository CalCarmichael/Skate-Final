//
//  CameraViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 04/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit

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
    
    func handleCameraPhoto() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shateButton_TouchUpInside(_ sender: Any) {
    
    
    
    
    
    } 
  
}

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
