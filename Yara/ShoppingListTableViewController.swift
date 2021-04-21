//
//  ShoppingListTableViewController.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/17/21.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }

    @IBAction func clearListButton(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Confirmation Clear List", message: "Are you sure you want to clear your shopping list?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { (action) in
            ShoppingListService.shoppingListByAisle = [String:[ExtendedIngredient]]()
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ShoppingListService.shoppingListByAisle.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ShoppingListService.getShoppingListAisles().count == 0 {
            return 1
        } else {
            let sections = ShoppingListService.getShoppingListAisles()
            let sectionAt = sections[section]
            return ShoppingListService.shoppingListByAisle[sectionAt]!.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListItemCell", for: indexPath)
        let aisle = ShoppingListService.getShoppingListAisles()[indexPath.section]
        let ingredient = ShoppingListService.shoppingListByAisle[aisle]![indexPath.row]
        
        let defaults = UserDefaults.standard
        let useMetricMeasurement = defaults.bool(forKey: "useMetric")
        
        
        
        
        let amountValue = useMetricMeasurement
            ? ingredient.measures.metric.amount
            : ingredient.measures.us.amount
        
        let amount =  amountValue.truncatingRemainder(dividingBy: 1.0) != 0
            ? String(format: "%.2f", amountValue)
            : String(Int(amountValue))
        
        let unit = useMetricMeasurement
            ? ingredient.measures.metric.unitShort
            : ingredient.measures.us.unitShort
        
        let ingrName = ingredient.nameClean!.lowercased()
        cell.textLabel?.text = "\(amount) \(unit) \(ingrName)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ShoppingListService.getShoppingListAisles()[section]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let aisle = ShoppingListService.getShoppingListAisles()[indexPath.section]
            let ingredient = ShoppingListService.shoppingListByAisle[aisle]![indexPath.row]
            ShoppingListService.removeIngredient(ingredient: ingredient)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

}
