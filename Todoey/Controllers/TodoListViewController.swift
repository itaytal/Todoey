//
//  ViewController.swift
//  Todoey
//
//  Created by Globes Design on 09/01/2019.
//  Copyright © 2019 Globes Design. All rights reserved.
//

import UIKit

class TodoListViewController: SwipeTableViewController, UISearchBarDelegate {
    
    var itemArray = [Item]()
    var filterArray = [Item]()
    
    var isSearchMode = false
    
    let dataFilPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        //print(dataFilPath!)
        
        tableView.rowHeight = 80.0

        loadItems()
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if isSearchMode == true {
            cell.textLabel?.text = filterArray[indexPath.row].title
            
            if filterArray[indexPath.row].done == true {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        else {
            cell.textLabel?.text = itemArray[indexPath.row].title
            
            if itemArray[indexPath.row].done == true {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearchMode{
            return filterArray.count
        }
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveitems()

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //delete data
    override func UpdateModel(at indexPath: IndexPath) {
        itemArray.remove(at: indexPath.row)
        saveitems()
    }
    
    //MARK  - add new items
    @IBAction func addButtonPress(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveitems()
        
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveitems() {
    
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilPath!)
        }
        catch {
            print("Error encoding item array")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        
            if let data = try? Data(contentsOf: dataFilPath!) {
                let decoder = PropertyListDecoder()
                do {
                    itemArray = try decoder.decode([Item].self, from: data)
                }
                catch{
                    print("error in decode \(error)")
                }
            }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text!.count == 0 {
            isSearchMode = false
        }
        else{
            let lower = searchBar.text!.lowercased()
            isSearchMode = true
            filterArray = itemArray.filter({$0.title.range(of: lower) != nil})
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            isSearchMode = false
            tableView.reloadData()
        }
    }

}

