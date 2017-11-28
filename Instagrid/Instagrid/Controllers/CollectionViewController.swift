//
//  CollectionViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit


/**
 CollectionView Controlelr that handles the display of the photo search on Pixabay
 */
class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.delegate = self
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ImageViewCell.self, forCellWithReuseIdentifier: "cellId")
  }
  
  // Define the number of cell to be displayed
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  // define the content of a cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    return cell
  }
  
  // defin e the layout and size of a cell
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
    
  }
    
}


