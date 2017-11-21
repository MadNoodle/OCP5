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
  

  
}
