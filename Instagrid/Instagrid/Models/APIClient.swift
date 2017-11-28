//
//  APIClient.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//



import Foundation
import UIKit

typealias ImageJSON = [String: Any]

class APIClient {
  
  let baseUrl = "https://pixabay.com/api/?key=6288350-cee414581d8372ab44a7d46dc&q="
  let searchOptions = "&image_type=photo&per_page=10"
  var images:[UIImage]?
  
  func getImagesAPI(query: String, completionHandler: @escaping (_ results: [UIImage]) -> ()) {
    
 
      let url = baseUrl + query + searchOptions
      let request = URLRequest(url: URL(string: url)!)
      
      let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        var imageArray = [UIImage]()
        if let data = data {
          
          do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
              if let results = json!["hits"] as? [[String:Any]] {
                for result in results {
                  if let webImageObject = try? WebImage(json: result){
                    let final = self.convertUrlToImage(urlString: webImageObject)
                    imageArray.append(final)}
                  print("RECUS: \(imageArray)")
                }
              }
              completionHandler(imageArray)

          } catch {
            print(error.localizedDescription)
          }
        }
        
      }
      task.resume()
    }
    
    
    
   func convertUrlToImage(urlString: WebImage) -> UIImage {
      var image : UIImage?
      
      if let url = URL(string: urlString.searchImage!){
        do{
          let data = try Data(contentsOf: url)
          image = UIImage(data: data)!
          
        } catch let error {
          print("error: \(error.localizedDescription)")
        }
      }
    return image!
}
}

