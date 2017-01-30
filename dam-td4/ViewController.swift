//
//  ViewController.swift
//  dam-td4
//
//  Created by Laura Daufeld on 30/01/2017.
//  Copyright © 2017 Laura Daufeld. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=en") {
            if let data = try? Data(contentsOf: url) {
                let xml = SWXMLHash.parse(data)
                for event in xml["data"]["categories"] {
                    
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

