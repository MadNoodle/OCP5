//
//  LayoutView.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 19/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 this class contains the informations on different layouts for collage
 Methods:
 ## getLayoutInfo()
 says which view is visible for which layout
 ## isFull()
 check if imageViews of a layout are fulffilled
 */
class CollageView: UIView  {
  
  /// Enum for the 3 initial Layouts
  enum Layouts:Int{
    case one = 1
    case two = 2
    case three = 3
  }
  
  // ////////////////////////// //
  // MARK: PROPERTIES& VARIABLES //
  // ////////////////////////// //
  
  
  /// Initialize the CollageView with the layout One
  var type:Layouts = .one
  ///Reference the logic in order to call logic functions on the view
  let logic = Logic()
  
  
  // ///////////// //
  // MARK: METHODS //
  // ///////////// //
  
  /** This function return an array of Bool that say which square/rect view is hidden or not for each kind of view
   - Important: the array follow this order *[RectTop,RectBot,squareOne,squareTwo,squareThree,squareFour]*
   - parameters:
   * name: one of the member of the Layout enum
   */
  internal func getLayoutInfo(name:Layouts) -> [Bool]{
    switch name {
    case .one:
      return [false,true,true,true,false,false]
    case .two:
      return [true,false,false,false,true,true]
    case .three:
      return [true,true,false,false,false,false]
    }
  }
  
  
  /**
   This function check if all imageViews in a collage Layout are filled by .image.
   - returns: Bool . If true the test is passed
   - Example:
   ````
   if view.isFull(){
   print(" this view is full")
   
   } else {
   print("this view is not full")}
   ````
   */
  internal func isFull() -> Bool{
    //SquareOne ImageView
    let view1 = self.viewWithTag(1) as! UIImageView
    //SquareTwo ImageView
    let view2 = self.viewWithTag(2) as! UIImageView
    //SquareThree ImageView
    let view3 = self.viewWithTag(3) as! UIImageView
    //SquareFour ImageView
    let view4 = self.viewWithTag(4) as! UIImageView
    //RectTop ImageView
    let view5 = self.viewWithTag(5) as! UIImageView
    //RectBot ImageView
    let view6 = self.viewWithTag(6) as! UIImageView
    
    // Initialize the validation @false in order for the logic to compute true
    var checkSuccess = false
    
    // call the logic function to choose the right function to evaluate if full according to the layout
    switch self.type{
    case .one:
      checkSuccess = logic.checkIfFullThreeViewsLayout(view3, view4, view5)
    case .two:
      checkSuccess = logic.checkIfFullThreeViewsLayout(view1, view2, view6)
    case .three:
      checkSuccess = logic.checkIfFullFourViewsLayout(view1, view2, view3, view4)
    }
    return checkSuccess
  }
  
  internal func imageToEdit(id:Int) -> UIImageView?{
    let view = self.viewWithTag(id) as! UIImageView
    return view
  }
}







