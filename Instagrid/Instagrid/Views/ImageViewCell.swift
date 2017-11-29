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
  
  var Button : UIButton = {
    let useButton = UIButton(frame: CGRect(x: 8, y: 200 - 8 , width: 50, height: 50))
  useButton.setTitle("USE IMAGE", for: .normal)
  useButton.setTitleColor(UIColor(red: 16/255.0, green: 102/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
  useButton.addTarget(self, action: #selector(useImage), for: .touchUpInside)
    return useButton
  }()
  
  // MARK: METHODS
  /**
   This function create a subView of type UIImageView and applies constraints to it
 */
  func setupImage(){
    // adding UIImage View in Cell
    addSubview(previewImage)
    addSubview(Button)
    
    
    //Horizontal Constraints
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":previewImage]))
    
    // VErtical Constraints
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":previewImage]))
   
    
  }
  

  
  @objc func useImage(sender: UIButton){}
  func displayContent(image: UIImage) {
    previewImage.image = image
    
  }
  
}
