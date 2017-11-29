//
//  ImageViewCell.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This class defines all the properties to create a collectionView cell in CollectionViewController
 Methods:
 ## setupImage()
 - instantiate image in a cell
 */
class ImageViewCell: UICollectionViewCell {
  
  // MARK: INITIALIZATION
  override init(frame: CGRect){
    super.init(frame:frame)
    
    setupImage()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
 
  // MARK: PROPERTIES
  /// this property initialize the preview image that will be instantiated in each cell
    var previewImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named:"")
    return imageView
  }()
  
  // MARK: METHODS
  /**
   This function create a subView of type UIImageView and applies constraints to it
 */
  func setupImage(){
    // adding UIImage View in Cell
    addSubview(previewImage)
    
    
    //Horizontal Constraints
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":previewImage]))
    
    // VErtical Constraints
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":previewImage]))
   
    
  }
  
  func displayContent(image: UIImage) {
    previewImage.image = image
    
  }
  
}
