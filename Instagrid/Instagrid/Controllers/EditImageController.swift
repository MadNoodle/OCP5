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
  var panGesture = UIPanGestureRecognizer()
  var pinch = UIPinchGestureRecognizer()
   let emojiVc = EmojiCollectionViewController(nibName: "EmojiCollectionViewController", bundle: nil) 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDragged))
    pinch = UIPinchGestureRecognizer(target: self, action: #selector(scale))
    
    self.view.addGestureRecognizer(pinch)
    self.textInput.addGestureRecognizer(panGesture)
    
    self.textInput.isUserInteractionEnabled = true
    self.view.isMultipleTouchEnabled = true
    
    
  
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
  
  
  
  
  
  
  @IBAction func insertImage(_ sender: Any) {
    
    emojiVc.modalPresentationStyle = .overFullScreen
    present(emojiVc, animated: true,completion:nil)
  }
  
  // ///////////////////////////// //
  // MARK: GESTURE CALLBACKS      //
  // ///////////////////////////// //
  
  
  @IBOutlet weak var container: UIView!
  
  @objc func viewDragged(){
    
    let newOrigin = panGesture.location(in: self.container)
    if newOrigin.x >= textInput.frame.width / 2 && newOrigin.y >= textInput.frame.height / 2 && newOrigin.x <= container.frame.width - textInput.frame.width / 2 && newOrigin.y <= container.frame.height - textInput.frame.height / 2{
      let newFrame = CGRect(x: newOrigin.x - (textInput.frame.width / 2), y: newOrigin.y - (textInput.frame.height / 2), width: textInput.frame.width, height: textInput.frame.height)
      textInput.frame = newFrame
      
    }
    else {print("Out of bounds")}
    
    print(newOrigin)
    print(container.frame.width)
    print(container.frame.height)
  }
  
  
  @objc func scale(sender:UIPinchGestureRecognizer){
    print(pinch.scale)
    var pointSize = textInput.font?.pointSize
    /// - Todo: set min and max font
    /// - Todo: clip to view bounds
    pointSize = ((sender.velocity > 0) ? 1 : -1) * 1 + pointSize!;
    textInput.font = UIFont( name: (textInput.font?.fontName)!, size: (pointSize)!)
    
    let newFrame = CGRect(x: textInput.frame.origin.x , y: textInput.frame.origin.y, width: textInput.frame.width * pinch.scale, height: textInput.frame.height * pinch.scale)
    
    textInput.sizeToFit()
    textInput.frame = newFrame
    textInput.setNeedsDisplay()
    pinch.scale = 1
    
  }
  
  // ///////////////////////////// //
  // MARK: APPLYING FILTERS       //
  // ///////////////////////////// //
  
  @IBAction func filter(_ sender: Any) {
    fxContainer.isHidden = false
    fontContainer.isHidden = true
  }
  
  
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
  
  // ///////////////////////////// //
  // MARK: TYPING AND EDITING TEXT     //
  // ///////////////////////////// //
  
  @IBOutlet weak var fontContainer: UIView!
  @IBAction func insertText(_ sender: Any) {
    container.addSubview(textInput)
    fontContainer.isHidden = false
    fxContainer.isHidden = true
    
  }
  
  var textInput: UITextField = {
    let textInput = UITextField(frame: CGRect(x: 100, y: 100, width: 500, height: 100))
    textInput.isUserInteractionEnabled = true
    
    textInput.placeholder = "Tap here to enter your text"
    textInput.textAlignment = .center
    textInput.placeHolderColor = UIColor.white
    
    textInput.font = UIFont(name:"delm-medium", size: 14)
    textInput.textColor = UIColor.white
    textInput.sizeToFit()
    return textInput
  }()
  
  
  // MARK : CHANGING FONTS TYPE
  @IBAction func switchfont1(_ sender: Any) {
    textInput.font = UIFont(name:"delm-medium", size: 14)
  }
  
  @IBAction func switchfont2(_ sender: Any) {
    textInput.font = UIFont(name:"ThirstySoftRegular", size: 10)
  }
  
  @IBAction func switchFont3(_ sender: Any) {
    textInput.font = UIFont(name:"Didot", size: 10)
  }
  
  // MARK : CHANGING FONTS COLOR
  @IBAction func yellow(_ sender: Any) {
    textInput.placeHolderColor = UIColor.yellow
    textInput.textColor = UIColor.yellow
  }
  
  @IBAction func blue(_ sender: Any) {
    textInput.placeHolderColor = UIColor.blue
    textInput.textColor = UIColor.blue
  }
  
  @IBAction func green(_ sender: Any) {
    textInput.placeHolderColor = UIColor.green
    textInput.textColor = UIColor.green
  }
  
  @IBAction func pink(_ sender: Any) {
    textInput.placeHolderColor = UIColor.purple
    textInput.textColor = UIColor.purple
  }
  @IBAction func white(_ sender: Any) {
    textInput.placeHolderColor = UIColor.white
    textInput.textColor = UIColor.white
  }
  
  @IBAction func black(_ sender: Any) {
    textInput.placeHolderColor = UIColor.black
    textInput.textColor = UIColor.black
  }
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
  func scaleFontSize (scale: CGFloat) {
    
    self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! * scale)!
  }
}
