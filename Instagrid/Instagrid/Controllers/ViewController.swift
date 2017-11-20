//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  // MARK: VARIABLE DECLARATIONS
  
  /// Logic initialisation for the collage view
  let collageView = CollageView()
  // Buttons declarations
  @IBOutlet weak var layoutTwoButton: UIButton!
  @IBOutlet weak var layoutThreeButton: UIButton!
  @IBOutlet weak var layoutOneButton: UIButton!
  // Buttons Hover Déclarations
  @IBOutlet weak var buttonTwoHover: UIImageView!
  @IBOutlet weak var buttonOneHover: UIImageView!
  @IBOutlet weak var buttonThreeHover: UIImageView!
  // Collage squares
  @IBOutlet private var squareOne:UIView!
  @IBOutlet private var squareTwo:UIView!
  @IBOutlet private var squareThree:UIView!
  @IBOutlet private var squareFour:UIView!
  @IBOutlet private var rectTop:UIView!
  @IBOutlet private var rectBot:UIView!
  
  // ///////////////////////////// //
  // MARK: CORE UI VIEW FUNCTIONS //
  // ///////////////////////////// //
  override func viewDidLoad() {
    super.viewDidLoad()
    showLayout(id:1)
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
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
 

  @IBOutlet weak var image1: UIImageView!
  @IBAction func importImage(_ sender: UIButton) {
    let image = UIImagePickerController()
    image.delegate = self
    image.sourceType = UIImagePickerControllerSourceType.photoLibrary
    image.allowsEditing = false
    self.present(image, animated:true){
      self.image1.isHidden = false
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
    {
      image1.image = image
    }
    else{
      print("Erreur de chargement d'image")
    }
    self.dismiss(animated: true, completion: nil)
  }
}

