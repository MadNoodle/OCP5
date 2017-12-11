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
  
  private var imageResults:[UIImage] = []
  private let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
  private var loading = UILabel()
  var webImage:UIImage? = UIImage()
  var imagePicked = 0
  var delegate : DataExchangeDelegate? = nil
  
  
  // /////////////////// //
  // MARK: VC LIFECYCLE //
  // ////////////////// //
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavbar()
    self.collectionView?.delegate = self
    collectionView?.backgroundColor = UIColor(red: 186/255.0, green: 215/255.0, blue: 230/255.0, alpha: 1.0)
    collectionView?.register(ImageViewCell.self, forCellWithReuseIdentifier: "cellId")
  }
  
  // initialize the number of cells to the number of results in array ImageResults
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageResults.count
  }
  
  //Populate the cells with images in array ImageResults
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ImageViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ImageViewCell
    // print("RECU2: \(imageResults)")
    cell.displayContent(image: (imageResults[indexPath.row]))
    return cell
  }
  
  // define the layout and size of a cell
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
    
  }
  // define actions when cell is tapped
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if delegate != nil {
      let image = imageResults[indexPath.row]
      delegate?.userSelectedImage(image: image)
    }
    //Store cell image in webImage that will be passed in Main VC
    // webImage = imageResults[indexPath.row]
    dismiss(animated: true, completion: nil)
    
  }
  
  // //////////// //
  // MARK: NAVBAR //
  // //////////// //
  
  private func setupNavbar(){
    
    //Properties
    let margin : CGFloat = 8
    let buttonWidth : CGFloat = 100
    let buttonHeight : CGFloat = 50
    
    //Instantiate Navbar
    let navBar: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
    
    let navBarWidth : CGFloat = navBar.frame.width
    //Set background color and alpha
    navBar.backgroundColor = UIColor.white
    //add to superview
    self.view.addSubview(navBar)
    
    addCancelButton(margin, buttonWidth, buttonHeight, navBar)
    
    addSearchButton(navBarWidth, margin, buttonWidth, buttonHeight, navBar)
    
    addSearchInputField(margin, buttonWidth, navBarWidth, buttonHeight, navBar)
  }
  
  fileprivate func addCancelButton(_ margin: CGFloat, _ buttonWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    //add cancel button
    //Create button
    let cancel = UIButton(frame: CGRect(x: margin, y: margin, width: buttonWidth, height: buttonHeight))
    // set title
    cancel.setTitle("Cancel", for: .normal)
    // Set title font
    cancel.titleLabel?.font = UIFont(name: "Delm-medium", size:20)
    //Set title Color RGBA
    cancel.setTitleColor(UIColor(red: 16/255.0, green: 102/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
    //Add action
    cancel.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
    // add it to navbar
    navBar.addSubview(cancel)
  }
  
  fileprivate func addSearchButton(_ navBarWidth: CGFloat, _ margin: CGFloat, _ buttonWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    //add Search button
    //Create button
    let search = UIButton(frame: CGRect(x: navBarWidth - (margin + buttonWidth), y: margin, width: buttonWidth, height: buttonHeight))
    // set title
    search.setTitle("Search", for: .normal)
    // Set title font
    search.titleLabel?.font = UIFont(name: "Delm-medium", size:20)
    //Set title Color RGBA
    search.setTitleColor(UIColor(red: 16/255.0, green: 102/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
    //Add action
    search.addTarget(self, action: #selector(self.performSearch), for: .touchUpInside)
    // add it to navbar
    navBar.addSubview(search)
  }
  
  fileprivate func addSearchInputField(_ margin: CGFloat, _ buttonWidth: CGFloat, _ navBarWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    //add textInput for search
    let searchInput = UITextField(frame: CGRect(x: (2 * margin + buttonWidth ), y: margin, width: navBarWidth - (2 * margin + buttonWidth ) - (2 * margin + buttonWidth ), height: buttonHeight))
    //Placeholdr text
    searchInput.placeholder = "Enter your request"
    searchInput.tag = 10
    // add it to navbar
    navBar.addSubview(searchInput)
  }
  
  /**
   Sets up the Navbar
   - cancel Button
   - textField for Input
   - Search Button
   */
  
  
  // ///////////////////// //
  // MARK: NAVBAR CALLBACKS //
  // ///////////////////// //
  
  /**
   Dismiss current controller and present Main Vc and purge WebImage
   */
  @objc func goBack(sender : UIButton){
    webImage = nil
    dismiss(animated: true, completion: nil)
  }
  
  /**
   Perform Search
   - important: Calls APIClient and is on main thread
   */
  @objc func performSearch(sender : UIButton){
    
    //TextField to perform the search
    let textfield = view.viewWithTag(10) as? UITextField
    
    // grab text from textfield
    if let query = textfield?.text {
      //Iniatialize empty array to store results
      self.imageResults = []
      //Display spinner while fetching results
      self.showSpinner()
      self.showLoading()
      //Call the APIClient with the search parameters
      
      // Grab the result on bg thread
      DispatchQueue.global(qos: .userInteractive).async{
        APIClient.getImagesAPI(query: query) {(results:[UIImage]) in
          
          //Iterate throught results and append it to result Array
          for result in results {
            self.imageResults.append(result)
          }
          //send results on main threads
          DispatchQueue.main.async {
            //Load data in  Collection View cells
            self.collectionView?.reloadData()
            //Hide spinner
            self.hideSpinner()
            self.hideLoading()
          }
        }
      }
    }
  }
  
  
  // /////////////////// //
  // MARK: LOADING SPINNER //
  // ////////////////// //
  
  /**
   Show loading text
   */
  private func showLoading(){
    // Instantiate the label
    loading = UILabel(frame: CGRect(x: 0, y: view.frame.height / 3 , width: view.frame.width, height: 40))
    // set the text
    loading.text = "Searching "
    // set the alignment
    loading.textAlignment = .center
    //set the font
    loading.font = UIFont(name: "Delm-medium", size: 40)
    //set text color
    loading.textColor = UIColor.white
    
    view.addSubview(loading)
  }
  /**
   Remove Loading Text
   */
  private func hideLoading(){
    loading.removeFromSuperview()
  }
  
  /**
   Instantiate, configure and show UIActivityIndicator
   */
  private func showSpinner(){
    
    // Position Activity Indicator in the center of the main view
    myActivityIndicator.center = view.center
    
    // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
    myActivityIndicator.hidesWhenStopped = false
    
    // Start Activity Indicator
    myActivityIndicator.startAnimating()
    
    //Show spinner
    view.addSubview(myActivityIndicator)
  }
  /**
   Kill UIActivityIndicator
   */
  private func hideSpinner(){
    myActivityIndicator.removeFromSuperview()
  }
}


