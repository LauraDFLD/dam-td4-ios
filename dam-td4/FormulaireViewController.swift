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
    
    //fonction de vérification de l'email
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    @IBOutlet weak var nomFormOutlet: UITextField!
    @IBOutlet weak var prenomFormOutlet: UITextField!
    @IBOutlet weak var emailFormOutlet: UITextField!
    @IBOutlet weak var telFormOutlet: UITextField!
    @IBOutlet weak var rappelerSwitch: UISwitch!
    
    @IBAction func envoyerAction(_ sender: Any) {
        
        //Vérification si tous les champs du formulaire sont remplis
        if (nomFormOutlet.text?.isEmpty)! || (prenomFormOutlet.text?.isEmpty)! || (emailFormOutlet.text?.isEmpty)! || telFormOutlet.text?.isEmpty ?? true {
            
            let alertController = UIAlertController(title: "Attention", message:
                "Vous n'avez pas rempli tous les champs", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        
        }
        else {
            //Vérification que le nom fait au moins 5 caractères
            if ((nomFormOutlet.text?.characters.count)! < 5 ){
                let alertValidNom = UIAlertController(title: "Attention", message:
                    "Le nom doit avoir au moins 5 caractères", preferredStyle: UIAlertControllerStyle.alert)
                alertValidNom.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertValidNom, animated: true, completion: nil)
            }
                //Vérification que le prénom fait au moins 5 caractères
            else if ((prenomFormOutlet.text?.characters.count)! < 5 ){
                let alertValidPrenom = UIAlertController(title: "Attention", message:
                    "Le prénom doit avoir au moins 5 caractères", preferredStyle: UIAlertControllerStyle.alert)
                alertValidPrenom.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertValidPrenom, animated: true, completion: nil)
            }
                //Vérification que le numéro de téléphone fait 10 caractères et est bien numérique
            else if  ((telFormOutlet.text?.characters.count)! <= 10) {
                let alertValidTel = UIAlertController(title: "Attention", message:
                    "Le numéro de téléphone doit avoir 10 caractères", preferredStyle: UIAlertControllerStyle.alert)
                alertValidTel.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertValidTel, animated: true, completion: nil)
                }

            //Verification du format de l'adresse email
            else if validateEmail(enteredEmail: emailFormOutlet.text!) == false {
                let alertValidEmail = UIAlertController(title: "Attention", message:
                    "L'email rentré n'est pas au bon format", preferredStyle: UIAlertControllerStyle.alert)
                alertValidEmail.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertValidEmail, animated: true, completion: nil)
            }
            else{
            
                //Creation de la vue email
                let mailVC = MFMailComposeViewController()
            
                //Corps du mail
            
            
                let messageBody = "<p><b><u>Nom: </u></b>\(nomFormOutlet.text!)<p> <p><b><u>Prénom: </u></b>\(prenomFormOutlet.text!)<p> <p><b><u>Email: </u></b>\(emailFormOutlet.text!)<p> <p><b><u>Téléphone: </u></b>\(telFormOutlet.text!)<p> <p><b><u>Etre rappelé: </u></b>\(rappelerSwitch.isOn)<p>"
            
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
