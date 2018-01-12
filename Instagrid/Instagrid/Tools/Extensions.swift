//
//  Extensions.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 03/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit


/**
 All class extensions needed for the program
 */


/// Add one property and one method to UITextField
extension UITextField{
  
  //Color of placeholder text
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
    }
  }
  
  // Scale font method
  func scaleFontSize (scale: CGFloat) {
    
    self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! * scale)!
  }
}

/// This extension create colors from RGB using the 255 index
extension UIColor {
  // Setup custom colours we can use throughout the app using hex values
  static let hoverBlue = UIColor(red: 16, green: 102, blue: 152, a: 0.7)
  
  // Create a UIColor from RGB
  convenience init(red: Int, green: Int, blue: Int, a: CGFloat ) {
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: a
    )
  }
  
}

/// This extension force the UIPicker
/// to be displayed in landscape mode
extension UIImagePickerController
{
  override open var shouldAutorotate: Bool {
    return true
  }
  override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    return .all
  }
}

extension ViewController {
  // /////////////////////////////// //
  // MARK: - DEVICE ADAPTATION METHODS //
  // ////////////////////////////// //
  
  /**
   Function to check if the current device is an iphone or ipad
   - important: if it is an ipad all the UIAlertController
   and UIActivityViewController are displayed as popover
   */
   func IpadIphoneAdaptation (controller: UIViewController){
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
   Function to check if the current device orientation
   and forces the UIActivityViewController to be
   displayed in landscape if landscape
   */
   func forceLandscape() {
    orientation = Logic.checkOrientation()
    // Check orientation to make the UI react according to it
    if  orientation {
      //Rotate UIActivityViewController in landscape
      let landscapeRawValue = UIInterfaceOrientation.landscapeLeft.rawValue
      UIDevice.current.setValue(landscapeRawValue, forKey: "orientation")
    } 
  }
}
