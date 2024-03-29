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
        
        self.dismiss(animated: false, completion: nil)
        
        
       

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
            
            let barViewControllers1 = segue.destination as! UITabBarController
            let destinationNv1 = barViewControllers1.viewControllers?[1] as! UINavigationController
            let destinationViewController1 = destinationNv1.viewControllers[0] as!Parques
            
            
            destinationViewController1.utilizador = autenticado
            
           
            
        }
        

        
        
        if(segue.identifier == "adminSegue"){
            let barViewControllers = segue.destination as! UITabBarController
            let destinationNv = barViewControllers.viewControllers?[0] as! UINavigationController
            let destinationViewController = destinationNv.viewControllers[0] as! MapViewController
            destinationViewController.utilizador = autenticado
       
    }
 
 
 
    
 
}
    func Entrar(){
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                
                self.autenticado = "user"
                
                
                self.performSegue(withIdentifier: "adminSegue", sender: self)
                
            }else{
                
                self.alertFail()
            }
        }
    }
    

    
    @IBAction func Login(_ sender: Any) {
        
        
             if (self.email.text! == "admin" && self.password.text! == "admin"){
                    
                    self.autenticado = "admin"
                    
                    self.performSegue(withIdentifier: "adminSegue", sender: self)
            
            } else {
                
                Entrar()
              
                
               
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
        
        

    
    


