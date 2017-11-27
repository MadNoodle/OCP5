//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate{
  
  
 
  // ///////////////////////////// //
  // MARK: VARIABLE DECLARATIONS
  // ///////////////////////////// //

  // Collage View
  @IBOutlet weak var collage: CollageView!
  
  @IBOutlet weak var fxContainer: UIView!


  // ///////////////////////////// //
  // MARK: LOGIC INITIALIZATION //
  // ///////////////////////////// //
  let collageView = CollageView()
  let logic = Logic()
  let image = UIImagePickerController()
  var orientation = false
  var imagePicked = 0
  var imageToEdit = 0

  
  // ///////////////////////////// //
  // MARK: CORE UI VIEW FUNCTIONS //
  // ///////////////////////////// //
    
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
    
    forceLandscape()
  }
  // /////////////////////////////// //
  // MARK: DEVICE ADAPTATION METHODS //
  // ////////////////////////////// //
  
  
  private func IpadIphoneAdaptation (controller: UIViewController){
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
      if let PopOver = controller.popoverPresentationController {
        PopOver.sourceView = self.view
      }
      present( controller, animated: true, completion: nil )
      print("ipad")
    } else{
      print("iphone")
      present(controller, animated: true){
      }
    }
  }
  
    private func forceLandscape() {
        orientation = logic.checkOrientation()
        // Check orientation to make the UI react according to it
        if  orientation {
            //Rotate UIActivityViewController in landscape
            let landscapeRawValue = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(landscapeRawValue, forKey: "orientation")
        } else {
            print("portrait")
        }
    }
  
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
  
  
  // ///////////////////////// //
  // MARK: SHOW LAYOUTS //
  // ///////////////////////// //
  
  // Collage squares
  @IBOutlet private var squareOne:UIView!
  @IBOutlet private var squareTwo:UIView!
  @IBOutlet private var squareThree:UIView!
  @IBOutlet private var squareFour:UIView!
  @IBOutlet private var rectTop:UIView!
  @IBOutlet private var rectBot:UIView!
  // Buttons declarations
  @IBOutlet weak var layoutTwoButton: UIButton!
  @IBOutlet weak var layoutThreeButton: UIButton!
  @IBOutlet weak var layoutOneButton: UIButton!
  // Buttons Hover Déclarations
  @IBOutlet weak var buttonTwoHover: UIImageView!
  @IBOutlet weak var buttonOneHover: UIImageView!
  @IBOutlet weak var buttonThreeHover: UIImageView!
  
  
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
  
  // ////////////////////// //
  // MARK: IMPORTING IMAGES //
  // ////////////////////// //
  
  // Image Containers
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  @IBOutlet weak var image5: UIImageView!
  @IBOutlet weak var image6: UIImageView!
  
  @IBAction func importImage(_ sender: UIButton) {
    imagePicked = 1
    popImageSource()
  }
  
  @IBAction func importimage2(_ sender: UIButton) {
    imagePicked = 2
    popImageSource()
  }
  
  @IBAction func importImage3(_ sender: UIButton) {
    imagePicked = 3
    popImageSource()
  }
  
  @IBAction func importImage4(_ sender: UIButton) {
    imagePicked = 4
   popImageSource()
  }
  
  @IBAction func importImage5(_ sender: UIButton) {
    imagePicked = 5
    popImageSource()
  }
  
  @IBAction func importImage6(_ sender: UIButton) {
    imagePicked = 6
    popImageSource()
  }
  
  // /////////////////////////// //
  // MARK: IMPORTING IMAGES      //
  // /////////////////////////// //
  
  /**
   Function to create an alert
   - Important: action added to dismiss the alert popup
   - parameters:
   - title: title of the alert appears in bold
   - message: Message prompted
   */

  private func popImageSource(){
    
   
    let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! UITableViewController
   

    image.delegate = self
    image.allowsEditing = false
    let alert = UIAlertController(title: "Choose an image", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    
    alert.addAction(UIAlertAction(title: "Pick from Library", style: .default, handler: { _ in
      self.ImportImageFromAlbum(self.image)
      self.present(self.image, animated: true)
    }))
    
    alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { _ in
      self.takePicture(self.image)
      self.present(self.image, animated: true)
    }))
    
    alert.addAction(UIAlertAction(title: "Search on Pixabay", style: .default, handler: { _ in
      self.present(vc2, animated: true, completion: nil)
     
    }))
    
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    IpadIphoneAdaptation(controller: alert)
  }

/**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
 */
 private func ImportImageFromAlbum(_ image: UIImagePickerController){
  self.image.sourceType = UIImagePickerControllerSourceType.photoLibrary
   self.present(image, animated: true, completion: nil)
  }

  /**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
   */
  private func takePicture(_ image: UIImagePickerController){
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
    {
      image.sourceType = UIImagePickerControllerSourceType.camera
    
    }
    else
    {
      let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
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
        self.image1.isHidden = false
        fxButton1.isHidden = false
      case 2:
        image2.image = image
        self.image2.isHidden = false
        fxButton2.isHidden = false
      case 3:
        image3.image = image
        self.image3.isHidden = false
        fxButton3.isHidden = false
      case 4:
        image4.image = image
        self.image4.isHidden = false
        fxButton4.isHidden = false
      case 5:
        image5.image = image
        self.image5.isHidden = false
        fxButton5.isHidden = false
      case 6:
        image6.image = image
        self.image6.isHidden = false
        fxButton6.isHidden = false
      default:
        print("Erreur de chargement d'image")
      }
        self.dismiss(animated: true, completion: {self.forceLandscape()})
    }
  }
  
  
  // ///////////////////////////// //
  // MARK: EXPORTING COLLAGE       //
  // ///////////////////////////// //
  


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
    fxButton1.isHidden = true
    fxButton2.isHidden = true
    fxButton3.isHidden = true
    fxButton4.isHidden = true
    fxButton5.isHidden = true
    fxButton6.isHidden = true
    
    let imageToSave = logic.convertUiviewToImage(from:collage)
   
    let activityController = UIActivityViewController(activityItems: [imageToSave!], applicationActivities: nil)
    IpadIphoneAdaptation(controller: activityController)

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
  
  
  // ///////////////////////////// //
  // MARK: EDITING IMAGES          //
  // ///////////////////////////// //
  
  
  //FX buttons
  @IBOutlet weak var fxButton1: UIButton!
  @IBOutlet weak var fxButton2: UIButton!
  @IBOutlet weak var fxButton3: UIButton!
  @IBOutlet weak var fxButton4: UIButton!
  @IBOutlet weak var fxButton5: UIButton!
  @IBOutlet weak var fxButton6: UIButton!
  
  // ///////////////////////////// //
  // MARK: EDITING IMAGES BUTTONS  //
  // ///////////////////////////// //
  
  @IBAction func editImageOne(_ sender: UIButton) {
    fxContainer.isHidden = false
    imageToEdit = 1
  }
  @IBAction func editImageTwo(_ sender: Any) {
    fxContainer.isHidden = false
    imageToEdit = 2
  }
  
  @IBAction func editImageThree(_ sender: Any) {
    fxContainer.isHidden = false
    imageToEdit = 3
  }
  
  @IBAction func editImageFour(_ sender: Any) {

    fxContainer.isHidden = false
    imageToEdit = 4
  }
  
  @IBAction func editImageFive(_ sender: Any) {
    fxContainer.isHidden = false
    imageToEdit = 5
  }
  
  @IBAction func editImageSix(_ sender: Any) {
    fxContainer.isHidden = false
    imageToEdit = 6
  }
  

  // ///////////////////////////// //
  // MARK: APPLYING FILTERS       //
  // ///////////////////////////// //
  

  @IBAction func ApplyInstantFilter() {
    logic.applyFilter("CIPhotoEffectInstant",on: collage.imageToEdit(id:imageToEdit)!)
    fxContainer.isHidden = true
  }
  @IBAction func applyNoirFilter(_ sender: Any) {
    logic.applyFilter("CIPhotoEffectNoir",on: collage.imageToEdit(id:imageToEdit)!)
    fxContainer.isHidden = true
  }
  @IBAction func applyProcessFilter(_ sender: Any) {
    logic.applyFilter("CIPhotoEffectProcess",on: collage.imageToEdit(id:imageToEdit)!)
    fxContainer.isHidden = true
  }
  @IBAction func applyTonalFilter(_ sender: Any) {
    logic.applyFilter("CIPhotoEffectTonal",on: collage.imageToEdit(id:imageToEdit)!)
    fxContainer.isHidden = true
  }
  
  @IBAction func applyTransferFilter(_ sender: Any) {
    logic.applyFilter("CIPhotoEffectTransfer",on: collage.imageToEdit(id:imageToEdit)!)
    fxContainer.isHidden = true
  }

  
 
}

/// This extension force the UIPicker to be displayed in landscape mode
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
