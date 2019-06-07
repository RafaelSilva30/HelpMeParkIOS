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
    
    
    
    var name: String!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = postData[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        cell.textLabel?.font = UIFont(name: "Arial-BoldMT", size:25);
        cell.backgroundView = UIImageView(image: UIImage(named: "table"))
        cell.textLabel?.textColor = UIColor.white
        cell.tintColor = UIColor.white

        
        
        
        return cell
        
            }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detalheParque", sender: self)
    }
    
   
    

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    ref.child("Parques").observe(.childAdded) { (snapshot) in
        let post = snapshot.key
        
        print(post)
        self.postData.append(post)
        self.tableView.reloadData()
        
        
        
        
        
    }
    
}
    
    


}



