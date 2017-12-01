//
//  EditImageController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 01/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class EditImageController: UIViewController {
  //Main VC
  let homeVc = UIViewController(nibName: "ViewController", bundle: nil)
  let fxEditor = FxEditor()
  let logic = Logic()
  //Var to store the image from HomeVC
  var tag : UIImageView?
  var finalImage = UIImage()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  //Load image after all the views had been initialize
  override func viewWillAppear(_ animated: Bool) {
    getImage()
  }
  // Image
  @IBOutlet weak var imageToEdit: UIImageView!
  
  @IBOutlet weak var fxContainer: UIView!
  //fetch image from collageView in HomeVC
  func getImage(){
    imageToEdit.image = tag?.image
  }
  
  //Dismiss controller to go back to main
  @IBAction func goBack(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  // Sends back the image to main view 
  @IBAction func useImage(_ sender: Any) {
    finalImage = fxEditor.convertUiviewToImage(from: self.container )!
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func filter(_ sender: Any) {
    fxContainer.isHidden = false
  }
  
  @IBAction func insertText(_ sender: Any) {
    container.addSubview(textInput)
    
  }
  
  
  @IBAction func insertImage(_ sender: Any) {
  }
  
  
  @IBOutlet weak var container: UIView!
  
  // ///////////////////////////// //
  // MARK: APPLYING FILTERS       //
  // ///////////////////////////// //
  
  @IBAction func applyInstantFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectInstant",on: imageToEdit)
  }
  @IBAction func applyNoirFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectNoir",on: imageToEdit)
    
  }
  @IBAction func applyProcessFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectProcess",on: imageToEdit)
    
  }
  @IBAction func applyTonalFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectTonal",on: imageToEdit)
  }
  
  @IBAction func applyTransferFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectTransfer",on: imageToEdit)
    
  }
  
  
  var textInput: UITextField = {
    
    let textInput = UITextField(frame: CGRect(x: 100, y: 100, width: 300, height: 50))
    textInput.isUserInteractionEnabled = true
    textInput.placeholder = "Tap here to enter your text"
    textInput.textAlignment = .center
    textInput.placeHolderColor = UIColor.white
    
    textInput.font = UIFont(name:"delm-medium", size: 20)
    textInput.textColor = UIColor.white
    textInput.sizeToFit()
    return textInput
  }()
  
  
}

extension UITextField{
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
    }
  }
}
