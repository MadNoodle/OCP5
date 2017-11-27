//
//  WebImage.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 27/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

class WebImage {
  let image : String!
  
  enum SerializationError:Error{
    case missing(String)
    case invalid(String,Any)
  }
  
  init(json:[String:Any]) throws {
    guard let imageURL = json["webformatURL"] as? String else {throw SerializationError.missing("error")}
    self.image = imageURL
  }
  
  static let baseUrl = "https://pixabay.com/api/?key=6288350-cee414581d8372ab44a7d46dc&q="
  static let urlOptions = "&image_type=photo&pretty=true"
  static func getImage(search query:String, completion: @escaping ([WebImage]) -> ()){
    
    let url = baseUrl + query + urlOptions
    let request = URLRequest(url: URL(string:url)!)
    
    let task = URLSession.shared.dataTask(with: request) {(data:Data?, response: URLResponse?, error: Error?) in
      var imageArray = [WebImage]()
      if let data = data {
        
        do {
          if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
          {
            
            if let results = json["hits"] as? [[String: Any]]{
              for result in results {
                if let imageObject = try? WebImage(json: result){
                  imageArray.append(imageObject)
                  //print(imageArray)
                }
              }
            }
          
          }
        } catch let error {
            print(error.localizedDescription)
        }
        completion(imageArray)
      }
    }
    task.resume()
  }
}
