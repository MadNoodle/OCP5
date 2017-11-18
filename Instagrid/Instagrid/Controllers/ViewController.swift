//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

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
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  
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
  


}

