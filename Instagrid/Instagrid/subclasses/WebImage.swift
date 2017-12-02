//
//  WebImage.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
/**
 Object to generate copies of images fetched from APIClient
 */
struct WebImage {
  
  let searchImage:String?
  
  init(json: [String:Any]){
    self.searchImage = json["webformatURL"] as? String
  }
}

