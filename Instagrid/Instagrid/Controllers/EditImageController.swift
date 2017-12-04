//
//  EditImageController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 01/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class EditImageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
  //Main VC
  let homeVc = UIViewController(nibName: "ViewController", bundle: nil)
  // Load Model
  let fxEditor = FxEditor()
  
  //Var to store the image from HomeVC
  var tag : UIImageView?
  //Init Gestures
  var panGesture = UIPanGestureRecognizer()
  var panGestureImg = UIPanGestureRecognizer()
  var pinch = UIPinchGestureRecognizer()
  var pinchImg = UIPinchGestureRecognizer()
  //Initialize Delegate for DataExhange Protocol
  var delegate : DataExchangeDelegate? = nil
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Instantiate Pan gestures for text and images
    panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDragged))
    panGestureImg = UIPanGestureRecognizer(target: self, action: #selector(imgDragged))
    self.textInput.addGestureRecognizer(panGesture)
    self.emoji.addGestureRecognizer(panGestureImg)
    
    // Instantiate Pinch gestures for text and images
    pinch = UIPinchGestureRecognizer(target: self, action: #selector(scale))
    pinchImg = UIPinchGestureRecognizer(target: self, action: #selector(scaleImg))
    self.view.addGestureRecognizer(pinch)
    self.view.addGestureRecognizer(pinchImg)
    
    // Gestures options
    self.emoji.isUserInteractionEnabled = true
    self.textInput.isUserInteractionEnabled = true
    self.view.isMultipleTouchEnabled = true
  }
  
  @IBOutlet weak var dummy: UIStackView!
  
  //Load image after all the views had been initialize
  override func viewWillAppear(_ animated: Bool) {
    getImage()
  }
  // Image
  @IBOutlet weak var imageToEdit: UIImageView!
  

  @IBOutlet weak var fxContainer: UIStackView!
  //fetch image from collageView in HomeVC
  func getImage(){
    imageToEdit.image = tag?.image
  }
  
  //Dismiss controller to go back to main
  @IBAction func goBack(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  // Sends back the image to main view 
  @IBAction func useImage(_ sender: Any) {
    if delegate != nil {
      let image = fxEditor.convertUiviewToImage(from: self.container )!
      delegate?.userSelectedImage(image: image)
    }
  
      if container.contains(emoji) {
        self.emoji.removeFromSuperview()
  }
    if container.contains(textInput) {
      self.textInput.removeFromSuperview()
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  // ///////////////////////////// //
  // MARK: GESTURE CALLBACKS      //
  // ///////////////////////////// //
  
  // Container View that will be captured, saved and sent back to Main Vc
  @IBOutlet weak var container: UIView!
  
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
    
    // Size of the font
    var pointSize = textInput.font?.pointSize
    // set the factor to increase or decrease the scale of font
    pointSize = ((sender.velocity > 0) ? 1 : -1) * 1 + pointSize!;
    //Set the font size
    textInput.font = UIFont( name: (textInput.font?.fontName)!, size: (pointSize)!)
    // set the new frame
    let newFrame = CGRect(x: textInput.frame.origin.x , y: textInput.frame.origin.y, width: textInput.frame.width * pinch.scale, height: textInput.frame.height * pinch.scale)
    
    textInput.sizeToFit()
    // allocate new frame
    textInput.frame = newFrame
    // re Display the frame if needed
    textInput.setNeedsDisplay()
    // Reset the scale to One if the user stop pincinhing and pinch again
    pinch.scale = 1
  }
  
  /**
   Callback function for PinchGesture on emoji.
   It handles the scaling of font and frame
   */
  @objc func scaleImg(sender:UIPinchGestureRecognizer){
    // set the new frame
    let newFrame = CGRect(x: emoji.frame.origin.x , y: emoji.frame.origin.y, width: emoji.frame.width * pinchImg.scale, height: emoji.frame.height * pinchImg.scale)
    // allocate new frame
    emoji.frame = newFrame
    // re Display the frame if needed
    emoji.setNeedsDisplay()
     // Reset the scale to One if the user stop pincinhing and pinch again
    pinchImg.scale = 1
  }
  
  // ///////////////////////////// //
  // MARK: APPLYING FILTERS       //
  // ///////////////////////////// //
  
  @IBAction func filter(_ sender: Any) {
    fxContainer.isHidden = false
    fontContainer.isHidden = true
  
    
  }
  
  
  @IBAction func applyInstantFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectInstant",on: imageToEdit)
  }
  @IBAction func applyNoirFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectNoir",on: imageToEdit)
    
  }
  @IBAction func applyProcessFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectProcess",on: imageToEdit)
    
  }
  @IBAction func applyTonalFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectTonal",on: imageToEdit)
  }
  
  @IBAction func applyTransferFilter(_ sender: Any) {
    fxEditor.applyFilter("CIPhotoEffectTransfer",on: imageToEdit)
    
  }
  
  // ///////////////////////////// //
  // MARK: TYPING AND EDITING TEXT     //
  // ///////////////////////////// //
  

  @IBOutlet weak var fontContainer: UIStackView!
  @IBAction func insertText(_ sender: Any) {
    container.addSubview(textInput)
    fontContainer.isHidden = false
    fxContainer.isHidden = true
    dummy.isHidden = true
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
  
  
  // MARK : CHANGING FONTS TYPE
  @IBAction func switchfont1(_ sender: Any) {
    textInput.font = UIFont(name:"delm-medium", size: 14)
  }
  
  @IBAction func switchfont2(_ sender: Any) {
    textInput.font = UIFont(name:"ThirstySoftRegular", size: 10)
  }
  
  @IBAction func switchFont3(_ sender: Any) {
    textInput.font = UIFont(name:"Didot", size: 10)
  }
  
  // MARK : CHANGING FONTS COLOR
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
    dummy.isHidden = true
  }
  
  //Declare all the images
  let items = ["XMLID_1000_.png", "XMLID_1068_.png", "XMLID_1069_.png", "XMLID_1070_.png", "XMLID_1071_.png", "XMLID_1072_.png", "XMLID_1131_.png", "XMLID_1133_.png", "XMLID_1134_.png", "XMLID_1136_.png", "XMLID_1147_.png", "XMLID_1169_.png", "XMLID_1189_.png", "XMLID_1217_.png", "XMLID_1218_.png", "XMLID_1219_.png", "XMLID_1220_.png", "XMLID_1313_.png", "XMLID_1314_.png", "XMLID_1315_.png","XMLID_1327_.png", "XMLID_1427_.png", "XMLID_1428_.png", "XMLID_1429_.png", "XMLID_1430_.png", "XMLID_1517_.png", "XMLID_1577_.png", "XMLID_1806_.png", "XMLID_1807_.png", "XMLID_1808_.png", "XMLID_1809_.png", "XMLID_1810_.png", "XMLID_1811_.png", "XMLID_1812_.png", "XMLID_1813_.png", "XMLID_1821_.png", "XMLID_1822_.png", "XMLID_1840_.png", "XMLID_1841_.png", "XMLID_1842_.png", "XMLID_1843_.png", "XMLID_1844_.png", "XMLID_1845_.png", "XMLID_1846_.png", "XMLID_1865_.png", "XMLID_1866_.png", "XMLID_1867_.png", "XMLID_1868_.png", "XMLID_1869_.png", "XMLID_1870_.png", "XMLID_1871_.png", "XMLID_1872_.png", "XMLID_1873_.png", "XMLID_1874_.png", "XMLID_1875_.png", "XMLID_1876_.png", "XMLID_1884_.png", "XMLID_1885_.png", "XMLID_1886_.png", "XMLID_1888_.png", "XMLID_1889_.png", "XMLID_1890_.png", "XMLID_1891_.png", "XMLID_1892_.png", "XMLID_1893_.png", "XMLID_1894_.png", "XMLID_1895_.png", "XMLID_1896_.png", "XMLID_1897_.png", "XMLID_1910_.png", "XMLID_1925_.png", "XMLID_1926_.png", "XMLID_1927_.png", "XMLID_1928_.png", "XMLID_1929_.png", "XMLID_1930_.png", "XMLID_1931_.png", "XMLID_1958_.png", "XMLID_1969_.png", "XMLID_1970_.png", "XMLID_1971_.png", "XMLID_1972_.png", "XMLID_1973_.png", "XMLID_1974_.png", "XMLID_1975_.png", "XMLID_1976_.png", "XMLID_1977_.png", "XMLID_1978_.png", "XMLID_1979_.png", "XMLID_1980_.png", "XMLID_1981_.png", "XMLID_1983_.png", "XMLID_1984_.png", "XMLID_1985_.png", "XMLID_1986_.png", "XMLID_1987_.png", "XMLID_1988_.png", "XMLID_673_.png", "XMLID_674_.png", "XMLID_787_.png", "XMLID_993_.png"
  ]
  
  
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
    myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    myCollectionView.backgroundColor = UIColor.hoverBlue
    
    //add the collection to the superview
    self.view.addSubview(myCollectionView)
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! CollectionViewCell
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
  var emoji: UIImageView = {
    let emoji = UIImageView(frame: CGRect(x: 100, y: 100, width: 25, height: 25))
    emoji.isUserInteractionEnabled = true
    return emoji
  }()
  

}




