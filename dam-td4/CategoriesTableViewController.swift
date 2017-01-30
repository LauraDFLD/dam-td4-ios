//
//  CategoriesTableViewController.swift
//  dam-td4
//
//  Created by Laura Daufeld on 30/01/2017.
//  Copyright © 2017 Laura Daufeld. All rights reserved.
//

import UIKit
import SWXMLHash

struct Element {
    var id: Int
    var img: String
    var name: String
    var id_category: Int
}

struct Category {
    var id: Int
    var name: String
    var elements = [Element]()
}

class CategoriesTableViewController: UITableViewController {
    
    var categories = [Category]() // tableau de catégories


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=en") {
            if let data = try? Data(contentsOf: url) {
                let xml = SWXMLHash.parse(data)
                for cat in xml["data"]["categories"]["category"] { // parser les catégories
                    
                    //print(category["element"].element?.attribute(by: "id")?.text)
                    var tmpElement = [Element]()
                    var category = Category( // création d'un objet catégorie
                        id: Int((cat.element?.attribute(by: "id")?.text)!)!,
                        name: (cat.element?.attribute(by: "name")?.text)!,
                        elements: tmpElement)
                    
                    
                    for elem in cat["element"] { // parser les éléments
                        let element = Element( // création d'un objet element
                            id: Int((elem.element?.attribute(by: "id")?.text)!)!,
                            img: (elem.element?.attribute(by: "image")?.text)!,
                            name: (elem.element?.attribute(by: "name")?.text)!,
                            id_category: Int((elem.element?.attribute(by: "category_id")?.text)!)!)
                        
                        tmpElement.append(element) // ajoute l'objet element au tableau d'éléments
                    }
                    
                    category.elements = tmpElement
                    categories.append(category) // ajoute l'objet category au tableau de catégories
                }
            }
        }
        
        print(categories[1].elements.count)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.section].elements[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
