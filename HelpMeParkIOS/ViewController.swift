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

class ViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var autenticado: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        email.text! = "a@gmail.com"
        password.text! = "123456"
        
        
        
        
    }
    
    
    func alertFail(){
        
        let alertFail = UIAlertController(title: "Login", message: "Erro na autenticação ! ", preferredStyle: .alert)
        
        alertFail.addAction(UIAlertAction(title: "Tentar de Novo", style: .default))
        
        let image = UIImage(named: "fail")
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame =  CGRect(x: 25, y: 18, width: 24, height: 24)
        alertFail.view.addSubview(imageView)
        
        self.present(alertFail, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "convidadoSegue"){
            let barViewControllers = segue.destination as! UITabBarController
            let destinationNv = barViewControllers.viewControllers?[0] as! UINavigationController
            let destinationViewController = destinationNv.viewControllers[0] as! MapViewController
            destinationViewController.utilizador = autenticado
        }
        
        if(segue.identifier == "loginSegue"){
            let barViewControllers = segue.destination as! UITabBarController
            let destinationNv = barViewControllers.viewControllers?[0] as! UINavigationController
            let destinationViewController = destinationNv.viewControllers[0] as! MapViewController
            destinationViewController.utilizador = autenticado
       
    }
        
    }
 
    

    
    @IBAction func Login(_ sender: Any) {
        
        
    
                Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                    
                if error == nil{
                    
                    self.autenticado = "userRegistado"
                    
                    
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                    
                    
                }else{
                    self.alertFail()
                    }
                }
    
        
    
        if (self.email.text! == "admin" && self.password.text! == "admin"){
            
            self.autenticado = "admin"
                
            self.performSegue(withIdentifier: "loginSegue", sender: self)
            
        } else {
            
            
            self.alertFail()
            
        }
    }
        
        
        
    
    
    @IBAction func performSegueRegistar(_ sender: Any) {
        performSegue(withIdentifier: "Segueidentifier", sender: self)
    
    
    
        }
    
    @IBAction func EntrarComoConvidado(_ sender: Any) {
        
        self.autenticado = "convidado"
        
       
        self.performSegue(withIdentifier: "convidadoSegue", sender: self)
        
        
    }
    
    
    


    }
        
        

    
    


