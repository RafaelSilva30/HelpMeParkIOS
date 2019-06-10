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
    
    
    
    
    var selectedLabel:String?
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return parquesList.count
        
        
    }
    
    
    
    @IBOutlet weak var nrlugares: UILabel!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
     
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParqueViewCell
        
        
        
        cell.lblName.text = self.parquesList[indexPath.row].nomeParque

        
        //Label do Nome
        cell.lblName.font = UIFont(name: "Arial-BoldMT", size:30);
        cell.lblName.textColor = UIColor.white
        cell.lblName.sizeToFit()
        

        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
       
        cell.backgroundView = UIImageView(image: UIImage(named: "table"))
       
        cell.tintColor = UIColor.white
 
     
       
        
        
    
        
        return cell
        
    }
 
    
    
   func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    let alert = UIAlertController(title: "Informacoes", message:"Nome do Parque: " + parquesList[indexPath.row].nomeParque, preferredStyle: UIAlertController.Style.alert)
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

    
  
   
    
    

    
    
    

    

    //SET FIREBASE REFERENCE
    let ref = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?
    
   
    
        @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            
        

        tableView.delegate = self
            
     
            tableView.backgroundView = UIImageView(image: UIImage(named: "table"))
           
            
            
  
            ref.child("Parques").observe(.childAdded,    with: {
                snapshot in
                
                print(snapshot)
                

            
                let nome = (snapshot.value as? NSDictionary)!["nome"] as! String

                print(nome)
                
            self.parquesList.append(Parque(nome: nome))
                
                self.tableView.reloadData()
                
                print(self.parquesList)
                
                
            })
    
        
    }
    
}


    






