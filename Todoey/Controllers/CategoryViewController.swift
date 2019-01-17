//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Globes Design on 16/01/2019.
//  Copyright © 2019 Globes Design. All rights reserved.
//

import UIKit

class CategoryViewController: SwipeTableViewController {

    
    var categoryArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "home"
        categoryArray.append(item1)
        
        let item2 = Item()
        item2.title = "work"
        categoryArray.append(item2)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
         cell.textLabel?.text = categoryArray[indexPath.row].title
        
         return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //     let destinationVc = segue.destination as! TodoListViewController
        
        
   // }
    

    @IBAction func addButtonPress(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user
            let newItem = Item()
            newItem.title = textField.text!
            self.categoryArray.append(newItem)
            
            self.tableView.reloadData()
            //self.saveitems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
