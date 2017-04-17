//
//  ViewController.swift
//  image-picker
//
//  Created by Aqib Shah on 4/16/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  let memeTextAttributes: [String: Any] = [
    NSStrokeColorAttributeName: UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName: 2
  ]
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  
    override func viewDidLoad() {
    super.viewDidLoad()
    topTextField.defaultTextAttributes = memeTextAttributes
    bottomTextField.defaultTextAttributes = memeTextAttributes
    topTextField.text = "TOP"
    topTextField.textAlignment = .center
    bottomTextField.text = "BOTTOM"
    bottomTextField.textAlignment = .center;
  }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
  @IBAction func pickImage(_ sender: Any) {
    let imagePickerCtrl = UIImagePickerController()
    imagePickerCtrl.delegate = self
    imagePickerCtrl.sourceType = .photoLibrary
    present(imagePickerCtrl, animated: true, completion: nil)
  }
  
  @IBAction func pickImageFromCamera(_ sender: Any) {
    let imagePickerCtrl = UIImagePickerController()
    imagePickerCtrl.delegate = self
    imagePickerCtrl.sourceType = .camera
    present(imagePickerCtrl, animated: true, completion: nil)
  }

  // MARK: UIImagePickerControllerDelegate Methods
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
      imageView.contentMode = .scaleAspectFit
    }
    
    dismiss(animated: true, completion: nil)
  }

}   
