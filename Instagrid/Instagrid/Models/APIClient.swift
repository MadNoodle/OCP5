//
//  APIClient.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 28/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//



import Foundation
import UIKit

/**
 APIClient to make the searcch request on PIXABAY
 Methods:
 ## getImagesAPI()
 Fetches images from server
 ## convertUrlToImage()
 convert images url tu UIImage object
 */
class APIClient {
  
 //Base url including API key
  let baseUrl = "https://pixabay.com/api/?key=6288350-cee414581d8372ab44a7d46dc&q="
  
  //options for request ( only image and number of result)
  @IBInspectable
  let numberOfResults = "10"
  let searchOptions = "&image_type=photo&per_page="
  
 

  /**
   APIClient Main method
   - parameters:
      - query: String from textField in CollectionView
      - completionHandler:([UIImage] -> ())
   - returns: [UIImage]
  
   */
  func getImagesAPI(query: String, completionHandler: @escaping (_ results: [UIImage]) -> ())  {

      let url = baseUrl + query + searchOptions + numberOfResults
      let request = URLRequest(url: URL(string: url)!)
    
    // UrlSession to connect to Pixabay'server
      let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
         //Array to save results
        var imageArray = [UIImage]()
        if let data = data {
          do {
            //Parsing results
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
              if let results = json!["hits"] as? [[String:Any]] {
                for result in results {
                  //store results in a WebImage Object
                  // Warning the compiler bug throws an error "No calls to throwing functions occur within 'try' "
                  if let webImageObject = try? WebImage(json: result){
                    //Convert to UIImage
                    let final = self.convertUrlToImage(urlString: webImageObject)
                    imageArray.append(final)}
                 // print("RECUS: \(image Array)")
                }
              }
            //return an Array
              completionHandler(imageArray)
          } catch {
            print(error.localizedDescription)
          }
        }
      }
    //Launch the request
      task.resume()
    }
    
  /**
 This function convert a WebImage to UIImage
  - parameters:
    - urlString: WebImage from parse Json
   - returns:
      UIImage
   */
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

