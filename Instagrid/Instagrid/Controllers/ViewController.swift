//
//  ViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 17/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // MARK: VARIABLE DECLARATIONS
  
  // Buttons declarations
  @IBOutlet weak var layoutTwoButton: UIButton!
  @IBOutlet weak var layoutThreeButton: UIButton!
  @IBOutlet weak var layoutOneButton: UIButton!
  // Buttons Hover Déclarations
  @IBOutlet weak var buttonTwoHover: UIImageView!
  @IBOutlet weak var buttonOneHover: UIImageView!
  @IBOutlet weak var buttonThreeHover: UIImageView!
  
  // Layout Elements Delcarations
  @IBOutlet weak var squareOne: UIView!
  @IBOutlet weak var squareTwo: UIView!
  @IBOutlet weak var squareThree: UIView!
  @IBOutlet weak var squareFour: UIView!
  @IBOutlet weak var rectBot: UIView!
  @IBOutlet weak var rectTop: UIView!
  
  // MARK: CORE UI VIEW FUNCTIONS
  override func viewDidLoad() {
    super.viewDidLoad()
    showLayoutOne()
  }

  // MARK: BUTTONS INTERACTIONS
  @IBAction func selectlayoutOne() {
    showLayoutOne()
    buttonOneHover.isHidden = false
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = true
  }
  
  @IBAction func selectLayoutTwo() {
    showLayoutTwo()
    buttonOneHover.isHidden = true
    buttonTwoHover.isHidden = false
    buttonThreeHover.isHidden = true
  }
  
  @IBAction func selectLayoutThree() {
    showLayoutThree()
    buttonOneHover.isHidden = true
    buttonTwoHover.isHidden = true
    buttonThreeHover.isHidden = false
  }
  private func showLayoutOne(){
    rectTop.isHidden = false
    rectBot.isHidden = true
    squareOne.isHidden = true
    squareTwo.isHidden = true
    squareThree.isHidden = false
    squareFour.isHidden = false
  }

  private func showLayoutTwo(){
    rectTop.isHidden = true
    rectBot.isHidden = false
    squareOne.isHidden = false
    squareTwo.isHidden = false
    squareThree.isHidden = true
    squareFour.isHidden = true
  }
  private func showLayoutThree(){
    rectTop.isHidden = true
    rectBot.isHidden = true
    squareOne.isHidden = false
    squareTwo.isHidden = false
    squareThree.isHidden = false
    squareFour.isHidden = false
  }
}

