//
//  MyWebviewController.swift
//  dam-td4
//
//  Created by Laura Daufeld on 04/02/2017.
//  Copyright © 2017 Laura Daufeld. All rights reserved.
//

import UIKit
import SDWebImage

class MyWebviewController: UIViewController {
    
    //var website: (nameElement: String, descrElement: String)!
    @IBOutlet weak var webView: UIWebView!
    
    var nameElement: String = ""
    var descrElement: String = ""
    var image: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("webview")
        
        // titre de la webview
        self.title = self.nameElement
        
        /*if categories[indexPath.section].elements[indexPath.row].image_large != "" {
         imageView1.backgroundColor = UIColor.black
         self.imageView1.image = UIImage(named: "pandaroux")
         imageView1.contentMode = .scaleAspectFit
         }*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
