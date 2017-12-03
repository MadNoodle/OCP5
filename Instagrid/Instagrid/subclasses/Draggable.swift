//
//  Draggable.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 03/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class Draggable: UIView {
  
  
  override init(frame:CGRect){
    super.init(frame:frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    let touch = touches.first
    self.center = (touch?.location(in: self.superview))!
    
    
  }

}
