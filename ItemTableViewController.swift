//
//  ItemTableViewController.swift
//  MyTodo
//
//  Created by Ipan Ardian on 4/28/16.
//  Copyright © 2016 Ipan Ardian. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    // MARK: Properties
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let savedItems = loadItems() {
            items += savedItems
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "itemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! itemTableViewCell
        
        let item = items[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            
            // Save to persistence data
            saveItems()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let nav = segue.destination as! UINavigationController
            let detailVC = nav.topViewController as! ViewController
            
            // Get the cell
            if let selectedCell = sender as? itemTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = items[(indexPath as NSIndexPath).row]
                detailVC.item = selectedItem
            }
        }
        else if segue.identifier == "addItem" {
            
        }
    }

    
    // MARK: Actions
    
    @IBAction func unwindToList(_ sender: UIStoryboardSegue) {
        let srcViewCon = sender.source as? ViewController
        let item = srcViewCon?.item
        if  (srcViewCon != nil && item?.name != "") {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Edit existing item
                items[(selectedIndexPath as NSIndexPath).row] = item!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            
                // Add a new item
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item!)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
            // Save to persistence data
            saveItems()
        }
    }
    
    func saveItems() {
        let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
        
        if !isSaved {
            print("Failed to save items")
        }
    }
    
    func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }

}
