//
//  RecuperarPassword.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 13/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//
import Foundation
import FirebaseDatabase
import UIKit
import  FirebaseAuth



class RecuperarPassword: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    @IBAction func recoverPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email.text!) { error in
            DispatchQueue.main.async {
                if self.email.text?.isEmpty==true || error != nil {
                    let resetFailedAlert = UIAlertController(title: "Erro na recuperação", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                if error == nil && self.email.text?.isEmpty==false{
                    let resetEmailAlertSent = UIAlertController(title: "Pedido Reposição Password", message: "Pedido de Reposição de Password enviado, por favor siga as instruções  do email para repor a sua password", preferredStyle: .alert)
                    resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailAlertSent, animated: true, completion: nil)
                }
            }
            self.performSegue(withIdentifier: "resetToLogin", sender: self)
        }
    }
    
}
