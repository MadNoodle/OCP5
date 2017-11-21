//
//  Logic.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 20/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

class Logic {
  /// This function authorize the user to import images from the library
  
  func convertUiviewToImage(from view:CollageView) -> UIImage?{
    
    // if images of the layout all contains an UIImage
    // Define the zone we want capture
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    // capture the image
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
  }
  
  ///Function to check if an UIImageView has an Image Inside
  func checkIfImageLoaded(view:UIImageView) -> Bool{
     var imageLoaded = false
      if view.image != nil{
        print("il y a une image")
        imageLoaded = true
      } else {
        imageLoaded = false
    }
    return imageLoaded
  }
  
  /// iterates throught an array of UIImageView ( such as a collageLayout) and return true if all UIImages contain an image
  func checkIfLayoutFullOneAndTwo(view:UIImageView, view2: UIImageView, view3:UIImageView ) -> Bool {
    var answer = false
    if checkIfImageLoaded(view: view) && checkIfImageLoaded(view: view2) && checkIfImageLoaded(view: view3){
      answer = true
      
      }
    else {answer = false}
    print(answer)
     return answer
 }
  
  func checkIfLayoutFullThree(view:UIImageView, view2: UIImageView, view3:UIImageView, view4:UIImageView) -> Bool {
    var answer = false
    if checkIfImageLoaded(view: view) && checkIfImageLoaded(view: view2) && checkIfImageLoaded(view: view3) && checkIfImageLoaded(view: view4){
      answer = true
    }
    else {answer = false}
    print(answer)
    return answer
  }
  

  }

