//
//  CollectionViewCell.swift
//
//
//  Created by Mathieu Janneau on 02/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 this class sets up the content of collectionViewCell Emoji Keyboard
 */
class CollectionViewCell: UICollectionViewCell {
  
  // Image View in the cell
  var imageView:UIImageView!
  
  // init the cell and add the image Subview
  override init(frame: CGRect) {
    imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    super.init(frame: frame)
    addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // this method purge the content of a cell before it is reused (so there is no Double images stacked in one cell)
  override func prepareForReuse() {
    contentView.subviews.forEach({ $0.removeFromSuperview() })
  }
  
  
 
}
