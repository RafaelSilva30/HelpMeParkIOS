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
    
  
    var parquesList = [parque1]()
    
    
    struct parque1 {
        
        let nome: String
    }
    
    
    var selectedLabel:String?
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return postData.count
        
        return parquesList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
     //Design Cell
        
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParqueViewCell
         
        cell.lblName.text = self.parquesList[indexPath.row].nome
        
       
        
      
        
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        cell.textLabel?.font = UIFont(name: "Arial-BoldMT", size:10);
        cell.backgroundView = UIImageView(image: UIImage(named: "table"))
        cell.textLabel?.textColor = UIColor.white
        cell.tintColor = UIColor.white
 
     
       
        
        
    
        
        return cell
        
    }
 
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        print("Row \(indexPath.row)selected")
        selectedLabel = self.parquesList[indexPath.row].nome
        print(self.parquesList[indexPath.row].nome)
        performSegue(withIdentifier: "detalheParque", sender: self)
    }
    
   
   /*
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheParque",
        
            let nextScene = segue.destination as? DetailParque ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let data = parquesList[indexPath.row]
            print("hello")
            nextScene.nome = data.nomeParque!
        }
 
 */
    
    
    
   func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if(segue.identifier == "detalheParque") {
            let vc = segue.destination as! DetailParque
            
            vc.nome = selectedLabel!
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
            
    
        
    // IR BUSCAR OS PONTOS E ALTERAR SE ALGUM FOR ADICIONADO
         /*
    ref.child("Parques").observe(.childAdded) { (snapshot) in
        let post = snapshot.key
        
        print(post)
        self.postData.append(post)
        
        self.tableView.reloadData()
 
  */
        
         ref.child("Parques").observe(.childAdded,    with: {
                snapshot in
                
                print(snapshot)
                
                let nomeParque = (snapshot.value as? NSDictionary)!["nome"] as! String
                
                print(nomeParque)
                
                self.parquesList.append(parque1(nome: nomeParque))
                
                self.tableView.reloadData()
                
                print(self.parquesList)
                
                
            })
    
        
    }
    
}


    






