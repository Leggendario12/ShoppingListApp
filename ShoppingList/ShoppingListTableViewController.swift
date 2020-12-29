//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Daniel Montecillo on 2020-12-29.
//

import UIKit

class ShoppingListTableViewController: BaseTableViewController {
    var lists: [ShoppingList] = [ShoppingList].load()
    {
        didSet {
            lists.save()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping Lists"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems?.append(editButtonItem)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didSelectAdd(_ sender: UIBarButtonItem){
        requestInput(title: "Shopping list name", message: "Enter name for the new shopping list:", handler: {(listName) in let listCount = self.lists.count;
            let list = ShoppingList(name: listName, items: [], onUpdate: self.lists.save)
            self.lists.append(list)
            self.tableView.insertRows(at: [IndexPath(row: listCount, section: 0)], with: .top)
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        let list = lists[indexPath.row]
        cell.textLabel?.text = list.name

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        lists.swapAt(fromIndexPath.row, to.row)
    }
    
   
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ItemListViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let list = lists[indexPath.row]
                destinationViewController.list = list
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
