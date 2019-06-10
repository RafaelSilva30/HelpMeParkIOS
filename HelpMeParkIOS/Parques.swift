//
//  Parques.swift
//  HelpMeParkIOS
//
//  Created by Rafael Silva on 04/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class Parques: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    var parquesList = [Parque]()
    
    
    struct parque1 {
        
        let nome: String
    }
    
    
    var selectedLabel:String?
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return postData.count
        
        return parquesList.count
        
    }
    
    
    
    @IBOutlet weak var nrlugares: UILabel!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
     
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParqueViewCell
        
        
        
        cell.lblName.text = self.parquesList[indexPath.row].nomeParque
        cell.distancia.text = self.parquesList[indexPath.row].nrLugares + " lugares"
       
        
      
        
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        cell.textLabel?.font = UIFont(name: "Arial-BoldMT", size:10);
        cell.backgroundView = UIImageView(image: UIImage(named: "table"))
        cell.textLabel?.textColor = UIColor.white
        cell.tintColor = UIColor.white
 
     
       
        
        
    
        
        return cell
        
    }
 
    
    
   func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Informacoes", message: parquesList[indexPath.row].nomeParque, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(parquesList[indexPath.row].nomeParque)
        self.performSegue(withIdentifier: "detalheParque", sender: indexPath)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheParque" {
            let idx = sender as! IndexPath
            let vcdetalhe = (segue.destination as! DetailParque)
            vcdetalhe.parquesList = parquesList[idx.row].nomeParque
        }
    }
    
    
  
    
    
    

    
    
    

    

    //SET FIREBASE REFERENCE
    let ref = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?
    
    var postData = [String]()
    
        @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            
        tableView.backgroundView = UIImageView(image: UIImage(named: "tableBack"))

        tableView.delegate = self
            
    
        
  
         ref.child("Parques").observe(.childAdded,    with: {
                snapshot in
                
                print(snapshot)
                
<<<<<<< HEAD
                let nomeParque = (snapshot.value as? NSDictionary)!["nome"] as! String
                let lugares = (snapshot.value as? NSDictionary)!["lugares"] as! String
=======
                let nome = (snapshot.value as? NSDictionary)!["nome"] as! String
                		let lugares = (snapshot.value as? NSDictionary)!["lugares"] as! String
>>>>>>> 033159bb273f24bee8c51411720de05eb2031c20
            
                print(nome)
                
            self.parquesList.append(Parque(nome: nome,lugares: lugares))
                
                self.tableView.reloadData()
                
                print(self.parquesList)
                
                
            })
    
        
    }
    
}


    






