//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class ViewController: UIViewController {
  // Selected button hover declarations
  @IBOutlet weak var layoutOneSelected: UIImageView!
  @IBOutlet weak var layoutTwoSelected: UIImageView!
  @IBOutlet weak var layoutThreeSelected: UIImageView!
  
  //Main Layout display declarations
  @IBOutlet weak var mainLayout: LayoutView!
  @IBOutlet weak var squareOne: SquareView!
  @IBOutlet weak var squareTwo: SquareView!
  @IBOutlet weak var squareThree: SquareView!
  @IBOutlet weak var squareFour: SquareView!
  @IBOutlet weak var rectTop: RectView!
  @IBOutlet weak var rectBottom: RectView!
  
  
  
=======
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
  
  
  // ///////////////////////////// //
  // MARK: VARIABLE DECLARATIONS
  // ///////////////////////////// //
  // Buttons declarations
  @IBOutlet weak var layoutTwoButton: UIButton!
  @IBOutlet weak var layoutThreeButton: UIButton!
  @IBOutlet weak var layoutOneButton: UIButton!
  // Buttons Hover Déclarations
  @IBOutlet weak var buttonTwoHover: UIImageView!
  @IBOutlet weak var buttonOneHover: UIImageView!
  @IBOutlet weak var buttonThreeHover: UIImageView!
  // Collage View
  @IBOutlet weak var collage: CollageView!
  // Collage squares
  @IBOutlet private var squareOne:UIView!
  @IBOutlet private var squareTwo:UIView!
  @IBOutlet private var squareThree:UIView!
  @IBOutlet private var squareFour:UIView!
  @IBOutlet private var rectTop:UIView!
  @IBOutlet private var rectBot:UIView!
  // Image Containers
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  @IBOutlet weak var image5: UIImageView!
  @IBOutlet weak var image6: UIImageView!
  
  
  // ///////////////////////////// //
  // MARK: LOGIC INITIALIZATION //
  // ///////////////////////////// //
  let collageView = CollageView()
  let logic = Logic()
  let image = UIImagePickerController()
  var imagePicked = 0
  var orientation = false
  
  // ///////////////////////////// //
  // MARK: CORE UI VIEW FUNCTIONS //
  // ///////////////////////////// //
>>>>>>> temp
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Init UI with layout one & button one higlighted
    showLayout(id:1)
    collage.type = .one
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
    
    // InitSwipe Gesture as soon as the app launches
    let upSwipe = UISwipeGestureRecognizer(target:self, action:#selector(DragCollage(swipe :)))
     upSwipe.direction = UISwipeGestureRecognizerDirection.up
    let leftSwipe = UISwipeGestureRecognizer(target:self, action:#selector(DragCollage(swipe :)))
     leftSwipe.direction = UISwipeGestureRecognizerDirection.left
     self.view.addGestureRecognizer(leftSwipe)
    self.view.addGestureRecognizer(upSwipe)
    
     orientation = logic.checkOrientation()
    // Check orientation to make the UI react according to it
    if  orientation {
      //Rotate UIActivityViewController in landscape
      let landscapeRawValue = UIInterfaceOrientation.landscapeLeft.rawValue
      UIDevice.current.setValue(landscapeRawValue, forKey: "orientation")
      
    } else {
      
    }
  }
  
  
  // ///////////////////////// //
  // MARK: BUTTON INTERACTIONS //
  // ///////////////////////// //
  
  /// Shows layout One and highligth button One
  @IBAction func selectLayoutOne() {
    showLayout(id:1)
    collage.type = .one
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
  }
  
  /// Shows layout Two and highligth button Two
  @IBAction func selectLayoutTwo() {
    showLayout(id:2)
    collage.type = .two
    buttonOneHover.isHidden = true
    buttonTwoHover.isHidden = false
    buttonThreeHover.isHidden = true
  }
  
  /// Shows layout Three and highligth button Three
  @IBAction func selectLayoutthree() {
    showLayout(id:3)
    collage.type = .three
    buttonOneHover.isHidden = true
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = false
  }
  
  /// Populates Layout View with views of the selected type of collage layout
  func showLayout(id:Int){
    let displays = collageView.getLayoutInfo(name: CollageView.Layouts(rawValue: id)!)
    rectTop.isHidden = displays[0]
    rectBot.isHidden = displays[1]
    squareOne.isHidden = displays[2]
    squareTwo.isHidden = displays[3]
    squareThree.isHidden = displays[4]
    squareFour.isHidden = displays[5]
    
  }
  
<<<<<<< HEAD
  
  // //////////////////// //
  // MARK: LAYOUT CHOICE  //
  // //////////////////// //
  
  
  // press layout button 1 actions
  @IBAction func goTolayout1() {
    layoutOneSelected.isHidden = false
    layoutTwoSelected.isHidden = true
    layoutThreeSelected.isHidden = true
    rectTop.isHidden = false
    rectBottom.isHidden = true
    squareOne.isHidden = true
    squareTwo.isHidden = true
    squareThree.isHidden = false
    squareFour.isHidden = false
  }
  
  // press layout button 2 actions
  @IBAction func goToLayout2() {
    layoutOneSelected.isHidden = true
    layoutTwoSelected.isHidden = false
    layoutThreeSelected.isHidden = true
    rectTop.isHidden = true
    rectBottom.isHidden = false
    squareOne.isHidden = false
    squareTwo.isHidden = false
    squareThree.isHidden = true
    squareFour.isHidden = true
  }
  
  // press layout button 3 actions
  @IBAction func goToLayout3() {
    layoutOneSelected.isHidden = true
    layoutTwoSelected.isHidden = true
    layoutThreeSelected.isHidden = false
    rectTop.isHidden = true
    rectBottom.isHidden = true
    squareOne.isHidden = false
    squareTwo.isHidden = false
    squareThree.isHidden = false
    squareFour.isHidden = false
  }
  
=======
  // ////////////////////// //
  // MARK: IMPORTING IMAGES //
  // ////////////////////// //

  @IBAction func importImage(_ sender: UIButton) {
    imagePicked = 1
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
      self.image1.isHidden = false
    }
  }
  
  @IBAction func importimage2(_ sender: UIButton) {
    imagePicked = 2
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
     self.image2.isHidden = false
    }
  }
  
  @IBAction func importImage3(_ sender: UIButton) {
    imagePicked = 3
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
      self.image3.isHidden = false
    }
  }
  
  @IBAction func importImage4(_ sender: UIButton) {
    imagePicked = 4
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
      self.image4.isHidden = false
    }
  }
  
  @IBAction func importImage5(_ sender: UIButton) {
    imagePicked = 5
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
      self.image5.isHidden = false
    }
  }
  
  @IBAction func importImage6(_ sender: UIButton) {
    imagePicked = 6
    ImportImageFromAlbum(image)
    self.present(image, animated:true){
      self.image6.isHidden = false
    }
  }
  
/**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
 */
 private func ImportImageFromAlbum(_ image: UIImagePickerController){
    image.delegate = self
    image.sourceType = UIImagePickerControllerSourceType.photoLibrary
    image.allowsEditing = false
    
  }
  
/**
   Method to show the UIImagePickerController and handle the completion
  */
  internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
    {
      switch imagePicked {
      case 1:
        image1.image = image
      case 2:
        image2.image = image
      case 3:
        image3.image = image
      case 4:
        image4.image = image
      case 5:
        image5.image = image
      case 6:
        image6.image = image
      default:
        print("Erreur de chargement d'image")
      }
      self.dismiss(animated: true, completion: nil)
    }
  }
  // ///////////////////////////// //
  // MARK: EXPORTING              //
  // ///////////////////////////// //
  
>>>>>>> temp

  /** Callback Function for Swipe gesture
   - important: Double check of Device orientation and swipe direction to allow one swipe direction per orientation
 */
  @objc private func DragCollage(swipe:UISwipeGestureRecognizer){
    orientation = logic.checkOrientation()
    if orientation == false && swipe.direction == .up {
      share()
    } else if orientation == true && swipe.direction == .left {
      share()
    } else {
      print("this swipe is not allowed in this orientation")
    }
  }
  /**
   Check if collage is full and then process all the event for sharing
   */
  private func share(){
    if collage.isFull(){
      transformCollage()
      saveAndShare()
    } else {
      popAlert(title: "Attention", message:"tous les espaces ne sont pas remplis")
    }
  }
/**
   Function to create an alert
   - Important: action added to dismiss the alert popup
   - parameters:
      - title: title of the alert appears in bold
      - message: Message prompted
 */
  private func popAlert(title:String, message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
      alert.dismiss(animated: true, completion: nil)
    }))
    self.present(alert, animated: true)
  }
  
  /**
   Convert The collageView in UIImage and invoke the UIActivityViewController
   - Important: orientation of the UIActivityViewController is handle in viewDidLoad()
   */
  private func saveAndShare(){
    let imageToSave = logic.convertUiviewToImage(from:collage)
    let activityController = UIActivityViewController(activityItems: [imageToSave!], applicationActivities: nil)
    present(activityController, animated: true){
    }
  }
  
  
  /**
   Animate the Collage View
   - duration : 0.3
   */
private func transformCollage(){
  let transform = CGAffineTransform(translationX: 0, y: -600)
  UIView.animate(withDuration: 0.3, animations: { self.collage.transform = transform }) { (success) in if success { self.resetCollage()}}
  }
 
  /// Reset the collage to empty outside of the screen and animate the return in screen
  private func resetCollage(){
    self.image1.isHidden = true
    self.image2.isHidden = true
    self.image3.isHidden = true
    self.image4.isHidden = true
    self.image5.isHidden = true
    self.image6.isHidden = true
    self.image1.image = nil
    self.image2.image = nil
    self.image3.image = nil
    self.image4.image = nil
    self.image5.image = nil
    self.image6.image = nil
    UIView.animate(withDuration: 0.7,delay: 0.5,options: [], animations: { self.collage.transform = .identity})
  }
  

}


