//
//  EmojiCollectionViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 02/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class KeyboardView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }
  
     let items = ["XMLID_673_","XMLID_787_","XMLID_993_","XMLID_1000_","XMLID_1068_"]
    @IBOutlet weak var collectionView: MyCollectionView!
    
    class func instanceFromNib() -> KeyboardView {
      return UINib(nibName: "Keyboard", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! KeyboardView
    }
    
    override func awakeFromNib() {
      print("awaking from nib")
      collectionView.delegate = self
      collectionView.dataSource = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("adding numberOfItemsForSection")
      return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
      print("adding cell")
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath)
      cell.backgroundColor = UIColor.greenColor()
      return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      print("setting size..")
      return CGSizeMake(320, 350)
    }
}
