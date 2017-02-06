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
        
        self.title = "HOME" // titre de la page
        
        // récupération de la langue du systeme
        let lang = NSLocale.current.languageCode
        
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
    
    // permet de personnaliser le header des sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView() // créé la vue
        view.backgroundColor = UIColor.white // fond blanc
        
        let label: UILabel = UILabel() // créé un label
        label.frame = CGRect(x: 0, y: 0, width: Int(tableView.frame.size.width), height: 40) // défini sa taille
        label.text = categories[section].name // lui donne un titre
        label.font = UIFont.boldSystemFont(ofSize: 18.0) // défini taille du texte et met en gras
        label.textAlignment = NSTextAlignment.center // centre le texte
        label.textColor = UIColor.black // couleur de texte noir
        
        view.addSubview(label) // ajoute le label à la vue

        return view // retourne la vue
    }
    
    //  défini la hauteur du titre : obligatoire pour qu'il s'affiche
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    // clique sur une cellule
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // instantie la webview
        let web = self.storyboard?.instantiateViewController(withIdentifier: "MyWebView") as! MyWebviewController
        
        // défini et renseigne les variables de mywebviewcontroller à passer à la vue
        web.nameElement = categories[indexPath.section].elements[indexPath.row].name
        web.descrElement = categories[indexPath.section].elements[indexPath.row].descr
        web.image = categories[indexPath.section].elements[indexPath.row].image_large
        
        // push à la webview grace au controller
        self.navigationController?.pushViewController(web, animated: true)
    }
    
}
