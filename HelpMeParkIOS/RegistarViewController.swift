//
//  RegistarViewController.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 18/05/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistarViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func buttonRegistar(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                let alertSucess = UIAlertController(title: "Registo ", message: "Conta Registada com sucesso ! ", preferredStyle: .alert)
                
                
                let image = UIImage(named: "check")
                let imageView = UIImageView()
                imageView.image = image
                imageView.frame =  CGRect(x: 25, y: 18, width: 24, height: 24)
                alertSucess.view.addSubview(imageView)
                
                alertSucess.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertSucess, animated: true)
                self.performSegue(withIdentifier:"registerToLogin", sender: self)
                
            } else {
                
                let alertFail = UIAlertController(title: "Registo", message: " Falha no Registo ! ", preferredStyle: .alert)
                
                alertFail.addAction(UIAlertAction(title: "OK", style: .default))
                let image = UIImage(named: "fail")
                let imageView = UIImageView()
                imageView.image = image
                imageView.frame =  CGRect(x: 25, y: 18, width: 24, height: 24)
                alertFail.view.addSubview(imageView)
                
                self.present(alertFail, animated: true)
               
            }
        }
    }
    
    
}



