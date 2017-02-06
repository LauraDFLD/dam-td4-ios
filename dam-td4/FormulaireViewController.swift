//
//  FormulaireViewController.swift
//  dam-td4
//
//  Created by Jonathan on 30/01/2017.
//  Copyright © 2017 Laura Daufeld. All rights reserved.
//

import UIKit
import MessageUI

class FormulaireViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nomFormOutlet: UITextField!
    @IBOutlet weak var prenomFormOutlet: UITextField!
    @IBOutlet weak var emailFormOutlet: UITextField!
    @IBOutlet weak var telFormOutlet: UITextField!
    @IBOutlet weak var rappelerSwitch: UISwitch!
    
    @IBAction func envoyerAction(_ sender: Any) {
        
        let mailVC = MFMailComposeViewController()
        
        let messageBody = "Nom:\(nomFormOutlet.text!)\nPrénom:\(prenomFormOutlet.text!)\nEmail:\(emailFormOutlet.text!)\nTéléphone:\(telFormOutlet.text!)\nEtre rappelé:\(rappelerSwitch.isOn) "
        
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Ma demande de contact")
        mailVC.setMessageBody(messageBody, isHTML: false)
        
        print(messageBody)
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        else{
            present(mailVC, animated: true, completion: nil)
        }
        
        
        
        if nomFormOutlet.text?.isEmpty ?? true {
            print("textField is empty")
        } else {
            print("textField has some text")
        }

        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
