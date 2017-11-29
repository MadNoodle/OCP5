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
@IBDesignable
class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let Api = APIClient()
  var imageResults:[UIImage] = []
  let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavbar()
    self.collectionView?.delegate = self
    collectionView?.backgroundColor = UIColor(red: 186/255.0, green: 215/255.0, blue: 230/255.0, alpha: 1.0)
    collectionView?.register(ImageViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
  
  func showSpinner(){
    
    
    // Position Activity Indicator in the center of the main view
    myActivityIndicator.center = view.center
    
    // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
    myActivityIndicator.hidesWhenStopped = false
    
    // Start Activity Indicator
    myActivityIndicator.startAnimating()
    
    // Call stopAnimating() when need to stop activity indicator
    //myActivityIndicator.stopAnimating()
    
    view.addSubview(myActivityIndicator)
  }
  
  func hideSpinner(){
    myActivityIndicator.removeFromSuperview()
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
  // define the layout and size of a cell
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
    
  }
  

/// Setup Navbar
  func setupNavbar(){
    
    let margin : CGFloat = 8
    let buttonWidth : CGFloat = 100
    let buttonHeight : CGFloat = 50
    
    let navBar: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
    navBar.backgroundColor = UIColor.white
    self.view.addSubview(navBar)
    let navBarWidth : CGFloat = navBar.frame.width
    
    //add cancel button
    let cancel = UIButton(frame: CGRect(x: margin, y: margin, width: buttonWidth, height: buttonHeight))
    cancel.setTitle("Cancel", for: .normal)
    cancel.setTitleColor(UIColor(red: 16/255.0, green: 102/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
    cancel.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
    navBar.addSubview(cancel)
    
    //add Search button
    let search = UIButton(frame: CGRect(x: navBarWidth - (margin + buttonWidth), y: margin, width: buttonWidth, height: buttonHeight))
    search.setTitle("Search", for: .normal)
    search.setTitleColor(UIColor(red: 16/255.0, green: 102/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
    search.addTarget(self, action: #selector(self.performSearch), for: .touchUpInside)
    navBar.addSubview(search)
    
    //add textInput for search
    let searchInput = UITextField(frame: CGRect(x: (2 * margin + buttonWidth ), y: margin, width: navBarWidth - (2 * margin + buttonWidth ) - (2 * margin + buttonWidth ), height: buttonHeight))
    searchInput.placeholder = "Enter your request"
    searchInput.tag = 10
    navBar.addSubview(searchInput)
  }
  

  @objc func goBack(sender : UIButton){
    dismiss(animated: true, completion: nil)
  }
  
  @objc func performSearch(sender : UIButton){
    
    let textfield = view.viewWithTag(10) as? UITextField
    
      if let query = textfield?.text {
      self.imageResults = []
      self.showSpinner()
      Api.getImagesAPI(query: query) {(results:[UIImage]) in
        
        for result in results {
          
          self.imageResults.append(result)
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.hideSpinner()
          }
        }
      }
      
      
    }
  }
  
}
