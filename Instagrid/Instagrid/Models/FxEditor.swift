//
//  FxEditor.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 01/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
// needed for reference to UIImage for processing conversion
import UIKit
// needed to apply filter and process
import CoreImage

struct FxEditor{
  
  // forbid initialisation
  fileprivate init(){}
  
  /** Filter Lis
   CIPhotoEffectNoir
   CIPhotoEffectChrome
   CIPhotoEffectInstant
   CIPhotoEffectTransfer
   CIPhotoEffectProcess
   CIPhotoEffectTonal
   */
  
  static func applyFilter(_ filter:String, on visual:UIImageView ){
    
    //get height and width of original image
    let initWidth = visual.image?.size.width
    let initHeight = visual.image?.size.height
    
    // if there is image apply filter
    
      let context = CIContext(options: nil)
      let filter = CIFilter(name: filter)
      let ciImage = CIImage(image: visual.image!)
      filter?.setValue(ciImage, forKey: kCIInputImageKey)
      let result = filter?.outputImage!
      let cgImage = context.createCGImage(result!, from: (result?.extent)!)
      
      // This conditions solve a bug in CIImage that create flipped image if h>W
      if Int(initWidth!) <= Int(initHeight!){
        // force orientation if h>w
        let render = UIImage(cgImage: cgImage!, scale: CGFloat(1.0), orientation: (visual.image?.imageOrientation)!)
        visual.image = render
      }else{
        let render:UIImage = UIImage.init(cgImage: cgImage!)
        visual.image = render
      }
    
  }
  
  /// This function authorize the user to import images from the library
  
  static func convertUiviewToImage(from view:UIView) -> UIImage?{
    
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

