//
//  LayoutView.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 19/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

/// this class contains the informations on different layouts for collage
class CollageView: UIView  {
  var type:Layouts = .one
  
  let logic = Logic()
 /// Enum for the 3 initial Layouts
  enum Layouts:Int{
  case one = 1
  case two = 2
  case three = 3
  }

  
  
  /** This function return an array of Bool that say which suare/rect view is hidden or not for each kind of view
  - parameters:
  - name: one of the member of the Layout enum
 */
  func getLayoutInfo(name:Layouts) -> [Bool]{
    switch name {
    case .one:
      return [false,true,true,true,false,false]
    case .two:
      return [true,false,false,false,true,true]
    case .three:
      return [true,true,false,false,false,false]
      
    }
  }
  
  
  func isFull() -> Bool{
    let view1 = self.viewWithTag(1) as! UIImageView
    let view2 = self.viewWithTag(2) as! UIImageView
    let view3 = self.viewWithTag(3) as! UIImageView
    let view4 = self.viewWithTag(4) as! UIImageView
    let view5 = self.viewWithTag(5) as! UIImageView
    let view6 = self.viewWithTag(6) as! UIImageView
    var checkSuccess = false
    switch self.type{
    case .one:
      if view3.image != nil && view4.image != nil && view5.image != nil{
        print("BOOM")
        checkSuccess = true
      }else{
        print("PAS BOOM")
        checkSuccess = false
      }
    case .two:
      if view1.image != nil && view2.image != nil && view6.image != nil{
        print("BOOM")
        checkSuccess = true
      } else{
        print("PAS BOOM")
        checkSuccess = false
      }
      
    case .three:
      if view1.image != nil && view2.image != nil && view3.image != nil && view4.image != nil  {
        print("BOOM")
        checkSuccess = true
      } else {
        print("PAS BOOM")
        checkSuccess = false
      }
    }
    return checkSuccess
  }
  
  }



  
  
  

