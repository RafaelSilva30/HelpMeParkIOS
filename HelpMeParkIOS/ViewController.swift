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

    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) {
            (user, error) in
            if user != nil {
                print("com sucesso")
            }
            if error != nil {
                print("merda")
            }
        }
    }
    
}

