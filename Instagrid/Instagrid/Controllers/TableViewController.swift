//
//  TableViewController.swift
//  Instagrid
//
//  Created by Mathieu Janneau on 27/11/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  var array = [UIImage]()
  // MARK: PROPERTIES
  

  
  override func viewDidLoad() {
        super.viewDidLoad()
    WebImage.getImage(search: "cat") { (results:[WebImage]) in
      for result in results {
        let image = self.convertUrlToImage(urlString: result)
        self.array.append(image)
        print("\(self.array)\n\n")
      }
    }
    }

  func convertUrlToImage(urlString: WebImage) -> UIImage{
    var image : UIImage?
    
    if let url = URL(string:urlString.image){
      do{
        let data = try Data(contentsOf: url)
        image = UIImage(data: data)!
        
      } catch let error {
        print("error: \(error.localizedDescription)")
      }
    }
    
    return image!
  }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      // Table view cells are reused and should be dequeued using a cell identifier.
      let cellIdentifier = "SearchImage"
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchImage  else {
        fatalError("The dequeued cell is not an instance of SearchImage.")
      }
      
      // Fetches the appropriate meal for the data source layout.
      let search = array[indexPath.row]
      
   
      cell.searchImageVisual.image = search
    
      
      return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
