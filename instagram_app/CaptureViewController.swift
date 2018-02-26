//
//  CaptureViewController.swift
//  instagram_app
//
//  Created by Nicholas Rosas on 2/20/18.
//  Copyright © 2018 Nicholas Rosas. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    let vc: UIImagePickerController = UIImagePickerController()
    
    override func viewDidAppear(_ animated: Bool) {
       // print("appear")
        //self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //print("disappear")
        //showImagePicker = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        selectedImage.addGestureRecognizer(tapGesture)
        
        
        //vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        /*
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        */
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        //print("here")
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        selectedImage.image = resize(image: originalImage, newSize: CGSize(width: 1000, height: 1000))
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        if selectedImage.image == #imageLiteral(resourceName: "image_placeholder")
        || captionField.text == "" {
            displayAlert(errorMsg: "Please provide an image and a caption")
            return
        }
        self.activityIndicator.startAnimating()
        Post.postUserImage(image: selectedImage.image!, withCaption: captionField.text) { (success: Bool, error: Error?) in
            // code
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                print("success")
            }
            self.activityIndicator.stopAnimating()
            self.setupDefault()
        }
    }
    
    func setupDefault() {
        self.captionField.text = ""
        self.selectedImage.image = #imageLiteral(resourceName: "image_placeholder")
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: newSize.width, height: newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func displayAlert(errorMsg: String) {
        // create the alert
        let alert = UIAlertController(title: "Submission failed", message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}
