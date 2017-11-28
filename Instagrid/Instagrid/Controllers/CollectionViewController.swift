//
//  CollectionViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit


/**
 CollectionView Controller that handles the display of the photo search on Pixabay
 */
class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let Api = APIClient()
  var imageResults:[UIImage] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.delegate = self
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ImageViewCell.self, forCellWithReuseIdentifier: "cellId")
    
    Api.getImagesAPI(query: "cat") {(results:[UIImage]) in
      for result in results {
        self.imageResults.append(result)
        DispatchQueue.main.async {
          self.collectionView?.reloadData()
        }
        
      }
    }
    
    
    
  
    }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageResults.count
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ImageViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ImageViewCell
    print("RECU2: \(imageResults)")
    cell.displayContent(image: (imageResults[indexPath.row]))
    
    return cell
    
  }
  // defin e the layout and size of a cell
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
    
  }
  


  
}
