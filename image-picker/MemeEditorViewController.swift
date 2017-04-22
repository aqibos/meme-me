//
//  ViewController.swift
//  image-picker
//
//  Created by Aqib Shah on 4/16/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  // MARK: Outlets and Variables
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var navbar: UINavigationBar!
  
  let memeTextAttributes: [String: Any] = [
    NSStrokeColorAttributeName: UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName: -4
  ]
  
  // MARK: Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField(topTextField, withText: "TOP")
    configureTextField(bottomTextField, withText: "BOTTOM")
    shareButton.isEnabled = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  func configureTextField(_ textField: UITextField, withText: String = "") {
    textField.delegate = self
    textField.defaultTextAttributes = memeTextAttributes
    textField.text = withText
    textField.textAlignment = .center
  }
  
  // MARK: Actions
  
  @IBAction func pickImageFromGallery() { pickImage(sourceType: .photoLibrary) }
  @IBAction func pickImageFromCamera() { pickImage(sourceType: .camera) }
  
  func pickImage(sourceType: UIImagePickerControllerSourceType) {
    let imagePickerCtrl = UIImagePickerController()
    imagePickerCtrl.delegate = self
    imagePickerCtrl.sourceType = sourceType
    present(imagePickerCtrl, animated: true, completion: nil)
  }
  
  @IBAction func cancelMeme() {
    topTextField.text = "TOP"
    bottomTextField.text = "BOTTOM"
    imageView.image = nil
  }
  
  // TODO: Have separate method that creates an instance of Meme struct
  //       Then, call this method from 'completionWithItemsHandler'
  
  // Save generated meme to gallery (device storage)
  
  func saveMeme(memedImage: UIImage) {
    UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
  }
  
  
  // I don't really understand the expectations for this
  // As stated per Apple's documentation, the completionWithItemsHandler
  //   is called after the UIActivityViewController is dismissed. In other words,
  //   the image will already have been saved to the camera roll. Why must we 
  //   save the image again, and manually dismiss the UIActivityViewController, if 
  //   it is already being handled?
  @IBAction func shareMeme(_ sender: Any) {
    let meme = Meme(topText: topTextField.text!,
                    bottomText: bottomTextField.text!,
                    originalImage: imageView.image!,
                    memedImage: generateMemedImage())
    
    let activityViewCtrl = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
    activityViewCtrl.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
      if (completed) {
        self.saveMeme(memedImage: meme.memedImage)
        self.dismiss(animated: true, completion: nil)
      }
    }
    present(activityViewCtrl, animated: true, completion: nil)
  }
  
  func generateMemedImage() -> UIImage {
    toolbar.isHidden = true
    navbar.isHidden = true
    
    UIGraphicsBeginImageContext(view.frame.size)
    view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
    let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    toolbar.isHidden = false
    navbar.isHidden = false
    return memedImage
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
      shareButton.isEnabled = true
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: UITextFieldDelegate Methods
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Tag 0 refers top UITextField, and Tag 1 refers to bottom UITextField
    // Clear the text every time...
    textField.text = ""
  }
  
  // MARK: Handle UIKeyboard
  
  func keyboardWillShow(_ notification:Notification) {
    if bottomTextField.isFirstResponder {
      view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
  }
  
  func keyboardWillHide(_ notification:Notification) {
    view.frame.origin.y = 0
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.cgRectValue.height
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
}
