//
//  CollectionViewCell.swift
//
//
//  Created by Mathieu Janneau on 02/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  var imageView:UIImageView!
  
  override init(frame: CGRect) {
    imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    super.init(frame: frame)
    addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func prepareForReuse() {
    contentView.subviews.forEach({ $0.removeFromSuperview() })
    // replace contentView with the superview of the repeating content.
  }
  
  
 
}
