//
//  ViewController.swift
//  HelpMeParkIOS
//
//  Created by Alvaro on 11/05/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func Login(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                
                 self.performSegue(withIdentifier: "loginSegue", sender: self)
                
                
            }else{
                
                let alertFail = UIAlertController(title: "Login", message: "Erro na autenticação ! ", preferredStyle: .alert)
                
                alertFail.addAction(UIAlertAction(title: "Tentar de Novo", style: .default))
                
                let image = UIImage(named: "fail")
                let imageView = UIImageView()
                imageView.image = image
                imageView.frame =  CGRect(x: 25, y: 18, width: 24, height: 24)
                alertFail.view.addSubview(imageView)
                
                self.present(alertFail, animated: true)
        }
    }
        
    }
    
    
    @IBAction func performSegueRegistar(_ sender: Any) {
        performSegue(withIdentifier: "Segueidentifier", sender: self)}

    
    
}

