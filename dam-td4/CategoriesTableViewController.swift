//
//  CategoriesTableViewController.swift
//  dam-td4
//
//  Created by Laura Daufeld on 30/01/2017.
//  Copyright © 2017 Laura Daufeld. All rights reserved.
//

import UIKit
import SWXMLHash
import SDWebImage

struct Element {
    var id: Int
    var img: String
    var name: String
    var id_category: Int
    var image_large: String
    var descr: String
}

struct Category {
    var id: Int
    var name: String
    var elements = [Element]()
}

class CategoriesTableViewController: UITableViewController {
    
    var categories = [Category]() // tableau de catégories

    @IBAction func formButtonAction(_ sender: Any) {
        let formulaire = self.storyboard?.instantiateViewController(withIdentifier: "formulaireView") as! FormulaireViewController
        self.navigationController?.pushViewController(formulaire, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HOME"
        //UINavigationBar.appearance().barTintColor = UIColor.red
        
        /*if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }*/
        
        //tableView.reloadData()
        
        // récupération de la langue du systeme
        let lang = NSLocale.current.languageCode
        //print(lang!)
        
        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=" + lang!) {
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
                            id_category: Int((elem.element?.attribute(by: "category_id")?.text)!)!,
                            image_large: (elem.element?.attribute(by: "image_large")?.text)!,
                            descr: (elem.element?.attribute(by: "descr")?.text)!)
                        
                        tmpElement.append(element) // ajoute l'objet element au tableau d'éléments
                    }
                    
                    category.elements = tmpElement
                    categories.append(category) // ajoute l'objet category au tableau de catégories
                }
            }
        }
        
        //print(categories[1].elements.count)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCustom", for: indexPath) as! CategoriesCustoCell
        
        //cell.textLabel?.text = categories[indexPath.section].elements[indexPath.row].name
        
        cell.nomCustom.text = categories[indexPath.section].elements[indexPath.row].name
        
        /*img.setShowActivityIndicator(true)
        img.setIndicatorStyle(.gray)*/
        
        cell.imageCustom.sd_setImage(with: URL(string: categories[indexPath.section].elements[indexPath.row].img), placeholderImage: UIImage(named: "univers.png"))
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categories[section].name
    }*/
    
    // permet de centrer et personnaliser le header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
        let footerView = UIView(frame:rect)
        footerView.backgroundColor = UIColor.white
        
        let label: UILabel = UILabel()
        label.text = categories[section].name
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        label.textAlignment = NSTextAlignment.center

        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /*override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CategoriesCustoCell
        headerCell.backgroundColor = UIColor.cyan
        
        headerCell.text = "Europe";
        
        return headerCell
    }*/
    
    // clique sur une cellule
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*if categories[indexPath.section].elements[indexPath.row].image_large != "" {
            imageView1.backgroundColor = UIColor.black
            self.imageView1.image = UIImage(named: "pandaroux")
            imageView1.contentMode = .scaleAspectFit
        }*/
        
        print("on click")
        
        let web = self.storyboard?.instantiateViewController(withIdentifier: "MyWebView") as! MyWebviewController
        web.nameElement = categories[indexPath.section].elements[indexPath.row].name
        web.descrElement = categories[indexPath.section].elements[indexPath.row].descr
        web.image = categories[indexPath.section].elements[indexPath.row].image_large
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    /*func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        var title = UILabel()
        title.font = UIFont(name: "HelveticaNeue-Light", size: 12)!
        title.textColor = UIColor.black
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        header.backgroundView?.backgroundColor = UIColor.white
        
    }*/
    
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let label: UILabel = UILabel()
        label.text = categories[section].name
        
        label.textAlignment = NSTextAlignment.center
        headerView.addSubview(label)
        
        return label
    }*/
    
}
