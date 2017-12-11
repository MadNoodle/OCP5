//
//  EditImageController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 01/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class EditImageController: UIViewController {
  
  //MARK: PROPERTIES
  //Main VC
  let homeVc = UIViewController(nibName: "ViewController", bundle: nil)
  //Var to store the image from HomeVC
  var tag : UIImageView?
  var imHeigth : CGFloat?
  var imWidth : CGFloat?
  //Init Gestures
  var panGesture = UIPanGestureRecognizer()
  var panGestureImg = UIPanGestureRecognizer()
  var pinch = UIPinchGestureRecognizer()
  var pinchImg = UIPinchGestureRecognizer()
  //Initialize Delegate for DataExhange Protocol
  var delegate : DataExchangeDelegate? = nil
  
  //MARK: OUTLETS
  @IBOutlet weak var imageToEdit: UIImageView!
  @IBOutlet weak var fxContainer: UIStackView!
  @IBOutlet weak var dummy: UIStackView!
  // Container View that will be captured, saved and sent back to Main Vc
  @IBOutlet weak var container: UIView!
  @IBOutlet weak var fontContainer: UIStackView!
  
  // /////////////////////// //
  // MARK: LIFECYCLE METHODS //
  // /////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initPanGestures()
    setupGestureOptions()
  }
  
  //Load image after all the views had been initialize
  override func viewWillAppear(_ animated: Bool) {
    getImage()
  }
  
  // //////////////////// //
  // MARK: CONTENT IMPORT //
  // //////////////////// //
  
  //fetch image from collageView in HomeVC
  func getImage(){
    imageToEdit.image = tag?.image
  }
   // /////////////// //
   // MARK: NAVIGATION //
   // /////////////// //
  
  /**
 Dismiss controller to go back to main
 */
  @IBAction func goBack(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func useImage(_ sender: Any) {
    if delegate != nil {
      let image = FxEditor.convertUiviewToImage(from: self.container )!
      delegate?.userSelectedImage(image: image)
    }
    removeEmoji()
    removeTextField()
    dismiss(animated: true, completion: nil)
  }
  
  /**
   Remove emoji after sending back image on main controller
 */
  fileprivate func removeEmoji() {
    if container.contains(emoji) {
      self.emoji.removeFromSuperview()
    }
  }
  /**
   remove textField after sending back image on main controller
 */
  fileprivate func removeTextField() {
    if container.contains(textInput) {
      self.textInput.removeFromSuperview()
    }
  }
  
  // /////////////// //
  // MARK: GESTURES  //
  // /////////////// //
  
  fileprivate func initPanGestures() {
    // Instantiate Pan gestures for text and images
  
    panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDragged))
    panGestureImg = UIPanGestureRecognizer(target: self, action: #selector(imgDragged))
    self.textInput.addGestureRecognizer(panGesture)
    self.emoji.addGestureRecognizer(panGestureImg)
  }
  
  fileprivate func setupGestureOptions() {
    // Gestures options
    self.emoji.isUserInteractionEnabled = true
    self.textInput.isUserInteractionEnabled = true
    self.view.isMultipleTouchEnabled = true
  }
  
  
  /**
   Callback function for PanGesture on textField
   allow the user to move the text in the frame of the container
   */
  @objc func viewDragged(){
    //Grab the position of the touch and store it
    let newOrigin = panGesture.location(in: self.container)
    
    // Clamp the textField movement in the container  frame
    if newOrigin.x >= textInput.frame.width / 2 && newOrigin.y >= textInput.frame.height / 2 && newOrigin.x <= container.frame.width - textInput.frame.width / 2 && newOrigin.y <= container.frame.height - textInput.frame.height / 2 {
      
      // update the coordinates of the textField
      let newFrame = CGRect(x: newOrigin.x - (textInput.frame.width / 2), y: newOrigin.y - (textInput.frame.height / 2), width: textInput.frame.width, height: textInput.frame.height)
      textInput.frame = newFrame
    }
    else {
      print("Out of bounds")
    }
  }
  
  /**
   Callback function for PanGesture on Images
   allow the user to move the text in the frame of the container
   */
  @objc func imgDragged(){
    //Grab the position of the touch and store it
    let newOrigin = panGestureImg.location(in: self.container)
    
    // Clamp the textField movement in the container  frame
    if newOrigin.x >= emoji.frame.width / 2 && newOrigin.y >= emoji.frame.height / 2 && newOrigin.x <= container.frame.width - emoji.frame.width / 2 && newOrigin.y <= container.frame.height - emoji.frame.height / 2{
      
      // update the coordinates of the textField
      let newFrame = CGRect(x: newOrigin.x - (emoji.frame.width / 2), y: newOrigin.y - (emoji.frame.height / 2), width: emoji.frame.width, height: emoji.frame.height)
      emoji.frame = newFrame
    }
    else {
      print("Out of bounds")
    }
  }
  
  /**
   Callback function for PinchGesture on textField.
   It handles the scaling of font and frame
   */
  @objc func scale(sender:UIPinchGestureRecognizer){
   
  if sender.scale >= 1 && sender.scale <= 1.2 {
    // Size of the font
    var pointSize = textInput.font?.pointSize
    // set the factor to increase or decrease the scale of font
    pointSize = ((sender.scale > 0) ? 1 : -1) * 2 + pointSize!;
    //Set the font size
    textInput.font = UIFont( name: (textInput.font?.fontName)!, size: (pointSize)!)
    setNewFrame(for: textInput, scaleToApply: pinch.scale)
    }
    
  }
  
  /**
   Callback function for PinchGesture on emoji.
   It handles the scaling of font and frame
   */
  @objc func scaleImg(sender:UIPinchGestureRecognizer){
    setNewFrame(for: emoji, scaleToApply: pinchImg.scale)
  }
  
  
  /**
   Sets new frame according to the pinch gesture scale
   - parameters:
       - view: view that will receive new frame
       - scaleToApply: gesture's pinch scale
 */
  func setNewFrame(for view:UIView, scaleToApply: CGFloat){
    let scale = scaleToApply
    if scale >= 1 && scale <= 1.2 {
    let newFrame = CGRect(x: view.frame.origin.x , y: view.frame.origin.y, width: view.frame.width * scale, height: view.frame.height * scale)
    
      view.sizeToFit()
      // allocate new frame
      view.frame = newFrame
      // re Display the frame if needed
      view.setNeedsDisplay()
    }
    
  }
  
  
  // ///////////////////////////// //
  // MARK: APPLYING FILTERS       //
  // ///////////////////////////// //
  
  // show filter palette
  @IBAction func filter(_ sender: Any) {
    fxContainer.isHidden = false
    fontContainer.isHidden = true
  }
  
  @IBAction func applyInstantFilter(_ sender: Any) {
    FxEditor.applyFilter("CIPhotoEffectInstant",on: imageToEdit)
  }
  @IBAction func applyNoirFilter(_ sender: Any) {
    FxEditor.applyFilter("CIPhotoEffectNoir",on: imageToEdit)
    
  }
  @IBAction func applyProcessFilter(_ sender: Any) {
    FxEditor.applyFilter("CIPhotoEffectProcess",on: imageToEdit)
    
  }
  @IBAction func applyTonalFilter(_ sender: Any) {
    FxEditor.applyFilter("CIPhotoEffectTonal",on: imageToEdit)
  }
  
  @IBAction func applyTransferFilter(_ sender: Any) {
    FxEditor.applyFilter("CIPhotoEffectTransfer",on: imageToEdit)
    
  }
  
  
  // ///////////////////////////// //
  // MARK: TYPING AND EDITING TEXT     //
  // ///////////////////////////// //
  
  @IBAction func insertText(_ sender: Any) {
    container.addSubview(textInput)
    fontContainer.isHidden = false
    fxContainer.isHidden = true
    dummy.isHidden = true
    pinch = UIPinchGestureRecognizer(target: self, action: #selector(scale))
    self.view.addGestureRecognizer(pinch)
  }
  
  //Create a TextField Object
  var textInput: UITextField = {
    // Init Frame
    let textInput = UITextField(frame: CGRect(x: 100, y: 100, width: 500, height: 100))
    // Allow interaction and gestures
    textInput.isUserInteractionEnabled = true
    //set placeholder text & options
    textInput.placeholder = "Tap here to enter your text"
    textInput.textAlignment = .center
    textInput.placeHolderColor = UIColor.white
    //set text options
    textInput.font = UIFont(name:"delm-medium", size: 14)
    textInput.textColor = UIColor.white
    textInput.sizeToFit()
    return textInput
  }()
  
  // ////////////////////////// //
  // MARK : CHANGING FONTS TYPE //
  // ////////////////////////// //
  
  @IBAction func switchfont1(_ sender: Any) {
    textInput.font = UIFont(name:"delm-medium", size: 14)
  }
  
  @IBAction func switchfont2(_ sender: Any) {
    textInput.font = UIFont(name:"ThirstySoftRegular", size: 10)
  }
  
  @IBAction func switchFont3(_ sender: Any) {
    textInput.font = UIFont(name:"Didot", size: 10)
  }
  
  // ////////////////////////// //
  // MARK : CHANGING FONTS COLOR //
   // ////////////////////////// //
  
  
  @IBAction func yellow(_ sender: Any) {
    setColor(UIColor.yellow)
  }
  
  @IBAction func blue(_ sender: Any) {
    setColor(UIColor.blue)
  }
  
  @IBAction func green(_ sender: Any) {
    setColor(UIColor.green)
  }
  
  @IBAction func pink(_ sender: Any) {
    setColor(UIColor.purple)
  }
  @IBAction func white(_ sender: Any) {
    setColor(UIColor.white)
  }
  
  @IBAction func black(_ sender: Any) {
    setColor(UIColor.black)
  }
  
  //Stting colors for placeholder and text
  func setColor(_ color: UIColor){
    textInput.placeHolderColor = color
    textInput.textColor = color
  }
  
  // ///////////////////////////// //
  // MARK: ADDING IMAGES            //
  // ///////////////////////////// //
  
  @IBAction func insertImage(_ sender: Any) {
    setupCollection()
    dummy.isHidden = false
    pinchImg = UIPinchGestureRecognizer(target: self, action: #selector(scaleImg))
    self.view.addGestureRecognizer(pinchImg)
  }
  
  let items = EmojiData.data
  let cellId = "MyCell"
  
  /**
   This function instantiate the Emoji Collection View
   - important: Needs UICollectionViewDelegate & UICollectionViewDatasource
   - note: Cell is handled in CollectionViewCell.swift
   */
  func setupCollection(){
    
    //Instantiate the Flow Layout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //set cell size
    layout.itemSize = CGSize(width: 50, height: 50)
    
    //set scroll direction
    layout.scrollDirection = .horizontal
    
    //Set the frame of the collectionView
    let newFrame = CGRect(x: 0, y: self.view.frame.height - 200, width: self.view.frame.width, height: 200)
    let myCollectionView:UICollectionView = UICollectionView(frame: newFrame, collectionViewLayout: layout)
    
    // set the delegates for Collection
    myCollectionView.dataSource = self
    myCollectionView.delegate = self
    
    // register the custom
    myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    myCollectionView.backgroundColor = UIColor.hoverBlue
    
    //add the collection to the superview
    self.view.addSubview(myCollectionView)
  }
  
  var emoji: UIImageView = {
    let emoji = UIImageView(frame: CGRect(x: 100, y: 100, width: 25, height: 25))
    emoji.isUserInteractionEnabled = true
    return emoji
  }()
}

// //////////////////// //
// MARK: EXTENSION      //
// //////////////////// //

/**
 Extension that handles protocol conformation for collection View ( emoji Keyboard)
 */
extension EditImageController:  UICollectionViewDataSource, UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! CollectionViewCell
    myCell.imageView.image = UIImage(named:items[indexPath.row])
    myCell.backgroundColor = UIColor.clear
    return myCell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //Store cell image in webImage that will be passed in Main VC
    emoji.image = UIImage(named:items[indexPath.row])
    container.addSubview(emoji)
    collectionView.removeFromSuperview()
  }
  
}



