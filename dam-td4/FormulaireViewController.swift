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
        
        //Vérification des champs du formulaire
        if (nomFormOutlet.text?.isEmpty)! || (prenomFormOutlet.text?.isEmpty)! || (emailFormOutlet.text?.isEmpty)! || telFormOutlet.text?.isEmpty ?? true {
            
            let alertController = UIAlertController(title: "Attention", message:
                "Vous n'avez pas rempli tous les champs", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            //Creation de la vue email
            let mailVC = MFMailComposeViewController()
            
            //Corps du mail
            /*let messageBody = "Nom:\(nomFormOutlet.text!)\nPrénom:\(prenomFormOutlet.text!)\nEmail:\(emailFormOutlet.text!)\nTéléphone:\(telFormOutlet.text!)\nEtre rappelé:\(rappelerSwitch.isOn) "*/
            
            let messageBody = "<p><b><u>Nom:</u></b>\(nomFormOutlet.text!)<p> <p><b><u>Prénom:</u></b>\(prenomFormOutlet.text!)<p> <p><b><u>Email:</u></b>\(emailFormOutlet.text!)<p> <p><b><u>Téléphone:</u></b>\(telFormOutlet.text!)<p> <p><b><u>Etre rappelé:</u></b>\(rappelerSwitch.isOn)<p>"
            
            //Ajout des différents champs de l'email
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([])
            mailVC.setSubject("Ma demande de contact")
            mailVC.setMessageBody(messageBody, isHTML: true)
            
            print(messageBody)
            
            //Pour eviter pb emulateur
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
            else{
                //Fait apparaitre l'appli mail dans une sous vue
                present(mailVC, animated: true, completion: nil)
            }

        }

        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Reconnait le tap ou doubletap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FormulaireViewController.dismissKeyboard))
        
        
        //Ajout de la reconnaissance du geste à la vue
        view.addGestureRecognizer(tap)
    }
    
    //Fonction qui permet de faire disparaitre le clavier
    func dismissKeyboard() {
        view.endEditing(true)
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
