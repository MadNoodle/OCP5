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
  
 
}
