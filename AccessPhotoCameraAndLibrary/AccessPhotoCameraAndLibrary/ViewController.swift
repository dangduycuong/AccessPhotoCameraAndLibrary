//
//  ViewController.swift
//  AccessPhotoCameraAndLibrary
//
//  Created by duycuong on 5/2/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openLibrarybutton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
   
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imagePicked.image = selectedImage

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(sender: AnyObject) {

        let imageData = imagePicked.image

        let compressedJPGImage = UIImage(data:(imagePicked.image?.pngData())!)

//        func imageSaved(image:UIImage,didFinishSavingWithError error:Error,contextInfo:UnsafeMutableRawPointer?){
        
//        let alert = UIAlertView(title: "Wow",
//                                message: "Your image has been saved to Photo Library!",
//                                delegate: nil,
//                                cancelButtonTitle: "Ok")
//            self.alert(title:"Image saved to Photos!", message: "")
//            alert.show()
        func presentImagePickerController() {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = false
            
            present(imagePickerController, animated: true, completion: nil)
        }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
        
        func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
            guard error == nil else {
                //Error saving image
                return
            }
            //Image saved successfully
        }
        
    }

//    @IBAction func saveButton(_ sender: AnyObject) {
//        UIImageWriteToSavedPhotosAlbum(imagePicked.image!, nil, nil, nil)
//        let alert = UIAlertView(title: "Wow",message: "Your image has been saved to Photo Library!", delegate: nil, cancelButtonTitle: "Ok")
//        alert.show()
    }
    




