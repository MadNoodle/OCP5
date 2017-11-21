//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
  // ///////////////////////////// //
  // MARK: VARIABLE DECLARATIONS
  // ///////////////////////////// //
  /// Logic initialisation for the collage view
  let collageView = CollageView()
  let logic = Logic()
  let image = UIImagePickerController()
  var imagePicked = 0
  
  
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
  // Images
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  @IBOutlet weak var image5: UIImageView!
  @IBOutlet weak var image6: UIImageView!
  
  
  
  // ///////////////////////////// //
  // MARK: CORE UI VIEW FUNCTIONS //
  // ///////////////////////////// //
  override func viewDidLoad() {
    super.viewDidLoad()
    showLayout(id:1)
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
    
    
    let swipe = UISwipeGestureRecognizer(target:self, action:#selector(DragCollage(swipe :)))
    if UIDevice.current.orientation.isLandscape {
       swipe.direction = UISwipeGestureRecognizerDirection.left
      //Rotate UIActivityViewController in landscape
      let landscapeRawValue = UIInterfaceOrientation.landscapeLeft.rawValue
      UIDevice.current.setValue(landscapeRawValue, forKey: "orientation")
      print("Landscape")
    } else {
      swipe.direction = UISwipeGestureRecognizerDirection.up
      print("Portrait")
    }
    //ToDo:  je dois redraw pour activer le swipe left
    //ToDo: verifier que la vue est full
    self.view.addGestureRecognizer(swipe)
  }
  
  
  // ///////////////////////// //
  // MARK: BUTTON INTERACTIONS //
  // ///////////////////////// //
  
  /// Shows layout One and highligth button One
  @IBAction func selectLayoutOne() {
    showLayout(id:1)
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
  }
  
  /// Shows layout Two and highligth button Two
  @IBAction func selectLayoutTwo() {
    showLayout(id:2)
    buttonOneHover.isHidden = true
    buttonTwoHover.isHidden = false
    buttonThreeHover.isHidden = true
  }
  
  /// Shows layout Three and highligth button Three
  @IBAction func selectLayoutthree() {
    showLayout(id:3)
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
  
  func ImportImageFromAlbum(_ image: UIImagePickerController){
    image.delegate = self
    image.sourceType = UIImagePickerControllerSourceType.photoLibrary
    image.allowsEditing = false
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
  

  /// Callback Function for Swipe
  @objc private func DragCollage(swipe:UISwipeGestureRecognizer){
   transformCollage(gesture: swipe)
    share()
    }
  
  /// Convert The collageView in UIImage and invoke the UIActivityViewController
  func share(){
    if self.image1.image != nil {print("il y a une image")}
    let imageToSave = logic.convertUiviewToImage(from:collage)
    let activityController = UIActivityViewController(activityItems: [imageToSave!], applicationActivities: nil)
    present(activityController, animated: true){
    }
  }
  ///Animating the collageView
private func transformCollage(gesture: UISwipeGestureRecognizer){
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
    UIView.animate(withDuration: 0.7,delay: 0.5,options: [], animations: { self.collage.transform = .identity})
  }
}


