//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate, DataExchangeDelegate{
  
  // ///////////////////////////// //
  // MARK: VARIABLE DECLARATIONS
  // ///////////////////////////// //
  
  // Collage View
  @IBOutlet weak var collage: CollageView!
  //Collage View
  let collageView = CollageView()
  //Model
  let logic = Logic()
  //Initialize the Picker
  let image = UIImagePickerController()
  // Test Variables to fulfill conditionnal test in VC
  var orientation = false
  var imagePicked = 0
  
  //ViewControllers
  let vc2 = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
  let edit = EditImageController(nibName: "EditImageController", bundle: nil)
  
  
  // /////////////////// //
  // MARK: VC LIFECYCLE //
  // ////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Initialize delegations
    vc2.delegate = self
    edit.delegate = self
    image.delegate = self
    image.allowsEditing = false
    // Init UI with layout one & button one higlighted
    displayLayout(id: 1, type: .one, false, true, true)
    
    // InitSwipe Gesture as soon as the app launches
    //UpSwipe
    let upSwipe = UISwipeGestureRecognizer(target:self, action:#selector(DragCollage(swipe :)))
    upSwipe.direction = UISwipeGestureRecognizerDirection.up
    self.view.addGestureRecognizer(upSwipe)
    //LeftSwipe
    let leftSwipe = UISwipeGestureRecognizer(target:self, action:#selector(DragCollage(swipe :)))
    leftSwipe.direction = UISwipeGestureRecognizerDirection.left
    self.view.addGestureRecognizer(leftSwipe)
    
    //ForceLandscape for UIActivity Controller in we are in landsccapemode
    forceLandscape()
  }
  
  

  
  // /////////////////////////////// //
  // MARK: DEVICE ADAPTATION METHODS //
  // ////////////////////////////// //
  
  /**
   Function to check if the current device is an iphone or ipad
   - important: if it is an ipad all the UIAlertController and UIActivityViewController are displayed as popover
   */
  private func IpadIphoneAdaptation (controller: UIViewController){
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
      if let PopOver = controller.popoverPresentationController {
        PopOver.sourceView = self.view
      }
      present( controller, animated: true, completion: nil )
      //print("ipad")
    } else{
      //print("iphone")
      present(controller, animated: true){
      }
    }
  }

  /**
   Function to check if the current device orientation and forces the UIActivityViewController to be displayed in landscape if landscape
   */
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
    displayLayout(id: 1, type: .one, false, true, true)
  }
  
  /// Shows layout Two and highligth button Two
  @IBAction func selectLayoutTwo() {
    displayLayout(id: 2, type: .two, true, false, true)
  }
  
  /// Shows layout Three and highligth button Three
  @IBAction func selectLayoutthree() {
    displayLayout(id: 3, type: .three, true, true, false)
  }
  
  /**
   Populates Layout View with views of the selected type of collage layout
   - parameters:
     - id : Int number index of the layout
     - type: reference to Layouts enum
     - one: Bool
     - two: Bool
     - three: Bool
 */
  private func displayLayout(id:Int, type: Layouts,_ one:Bool, _ two: Bool, _ three: Bool){
    let displays = collageView.getLayoutInfo(name: Layouts(rawValue: id)!)
    rectTop.isHidden = displays[0]
    rectBot.isHidden = displays[1]
    squareOne.isHidden = displays[2]
    squareTwo.isHidden = displays[3]
    squareThree.isHidden = displays[4]
    squareFour.isHidden = displays[5]
    collage.type = type
    buttonOneHover.isHidden = one
    buttonTwoHover.isHidden = two
    buttonThreeHover.isHidden = three
  }
  
  // //////////////////////////////////////////////////// //
  // MARK: DELEGATION METHODS TO COMMUNICATE BETWEEN VCs  //
  // /////////////////////////////////////////////////// //
  
  //Receiver for image selected from web search
  func userSelectedImage(image: UIImage) {
    loadImageFromWeb(fromImage: image, to: imagePicked)
  }
  // ////////////////////// //
  // MARK: IMPORTING IMAGES //
  // ////////////////////// //
  
  // Image Containers
  @IBOutlet  var image1: UIImageView!
  @IBOutlet  var image2: UIImageView!
  @IBOutlet  var image3: UIImageView!
  @IBOutlet  var image4: UIImageView!
  @IBOutlet  var image5: UIImageView!
  @IBOutlet  var image6: UIImageView!
  
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
   */
  private func popImageSource(){
    
    // Initialize UIAlert controller
    let alert = UIAlertController(title: "Choose an image", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    // add import from library
    alert.addAction(UIAlertAction(title: "Pick from Library", style: .default, handler: { _ in
      self.ImportImageFromAlbum(self.image)
      self.present(self.image, animated: true)
    }))
    
    // add take pictures
    alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { _ in
      self.takePicture(self.image)
      self.present(self.image, animated: true)
    }))
    
    // add search on Pixabay
    alert.addAction(UIAlertAction(title: "Search on Pixabay", style: .default, handler: { _ in
      // Initialize second view controller to communicate with it
      self.vc2.imagePicked = self.imagePicked
      self.present(self.vc2, animated: true)
    }))
    
    // add cancel
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    
    //present as a popover if the Device is Ipad
    self.IpadIphoneAdaptation(controller: alert)
  }
  
  /**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
   - parameters:
   - image: UIImagePickerController
   */
  private func ImportImageFromAlbum(_ image: UIImagePickerController){
    self.image.sourceType = UIImagePickerControllerSourceType.photoLibrary
    self.present(image, animated: true, completion: nil)
  }
  
  /**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
   - parameters:
   - image: UIImagePickerController
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
        LoadImage(image, in: image1, hide: fxButton1)
      case 2:
        LoadImage(image, in: image2, hide: fxButton2)
      case 3:
        LoadImage(image, in: image3, hide: fxButton3)
      case 4:
        LoadImage(image, in: image4, hide: fxButton4)
      case 5:
        LoadImage(image, in: image5, hide: fxButton5)
      case 6:
        LoadImage(image, in: image6, hide: fxButton6)
      default:
        print("Erreur de chargement d'image")
      }
      self.dismiss(animated: true, completion: {self.forceLandscape()})
    }
  }
  
  /**
   Method to send images fetched from the web in the rigth UIImageView
   */
  public func loadImageFromWeb(fromImage: UIImage?, to target: Int ) {
    if let image = fromImage
    {
      switch target {
      case 1:
        LoadImage(image, in: image1, hide: fxButton1)
      case 2:
       LoadImage(image, in: image2, hide: fxButton2)
      case 3:
       LoadImage(image, in: image3, hide: fxButton3)
      case 4:
       LoadImage(image, in: image4, hide: fxButton4)
      case 5:
       LoadImage(image, in: image5, hide: fxButton5)
      case 6:
        LoadImage(image, in: image6, hide: fxButton6)
      default:
        print("Erreur de chargement d'image")
      }
    }
  }
  
  /**
   function to populate an image container with an image from source
   - parameters:
       - picture: UIImage to load
       - container: UIImageView where image have to be loaded
       - button: buttonto hide
  */
  func LoadImage(_ picture: UIImage, in container: UIImageView, hide button:UIButton){
    container.image = picture
    container.isHidden = false
    button.isHidden = false
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
    // Declare all the image containers to purge
    let containers = [image1,image2,image3,image4,image5,image6]
    //purge
    for container in containers {
      resetImage(container!)
    }
    // Animate the return of the empty colalge in the screen
    UIView.animate(withDuration: 0.7,delay: 0.5,options: [], animations: { self.collage.transform = .identity})
  }
  //reset one colalge UIImageView to empty
  private func resetImage(_ image:UIImageView){
    image.isHidden = true
    image.image = nil
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
  
  //Index of the UIImageView to Edit in collage
  var imageToEdit = 0
  //Variable to store the result from editing
  var imageToSendToEdit: UIImageView?
  
  let errorMessage = "désolé il n y a pas d images"
  // ///////////////////////////// //
  // MARK: EDITING IMAGES BUTTONS  //
  // ///////////////////////////// //
  
  @IBAction func editImageOne(_ sender: UIButton) {
    sendToEditor(imageIndex: 1, image: image1)
  }
  
  @IBAction func editImageTwo(_ sender: Any) {
    sendToEditor(imageIndex: 2, image: image2)
  }
  
  @IBAction func editImageThree(_ sender: Any) {
   sendToEditor(imageIndex: 3, image: image3)
  }
  
  @IBAction func editImageFour(_ sender: Any) {
   sendToEditor(imageIndex: 4, image: image4)
  }
  
  @IBAction func editImageFive(_ sender: Any) {
    sendToEditor(imageIndex: 5, image: image5)
  }
  
  @IBAction func editImageSix(_ sender: Any) {
    sendToEditor(imageIndex: 6, image: image6)
  }
  
  /**
   Method to send the content from UIImageView in Edit ViewController
   This method present MODALLY EditVc
   - parameters:
   - imageToEdit: Int identifier of the image in Collage
   */
  func sendToEditor(imageIndex:Int, image: UIImageView){
    imageToEdit = imageIndex
    if logic.checkIfImageLoaded(view: image){
      // ToDo: delegation???
      imageToSendToEdit = view.viewWithTag(imageToEdit)! as? UIImageView
      edit.tag = imageToSendToEdit
      //Present fxEditor Modally
      edit.modalPresentationStyle = .overFullScreen
      present(edit, animated: true,completion:nil)
    } else {
      print(errorMessage)
    }
  }
  
}




