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

    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("webview")
        
        // titre de la webview
        self.title = self.nameElement
        
        if image != "" {
            print(image)
            imageView2.backgroundColor = UIColor.black
            imageView2.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "univers.png"))
            imageView2.contentMode = .scaleAspectFit
        }
        else {
            webView.loadHTMLString(descrElement, baseURL: nil)
        }

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
