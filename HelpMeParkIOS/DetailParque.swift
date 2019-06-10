//
//  DetailParque.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 05/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class DetailParque: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var nrLugaresLbl: UILabel!
    
    @IBOutlet weak var PrecoBaseSemanaLbl: UILabel!
    var parquesList: String = ""
    
    let ref = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let parque = parquesList
        print(parque)
        
        
        ref.child("Parques").observe(.childAdded,    with: {
            snapshot in
            
            
            let nomeParque = (snapshot.value as? NSDictionary)!["nome"] as! String
            let nrLugares = (snapshot.value as? NSDictionary)!["lugares"] as! String
            let PrecoBaseSemana = (snapshot.value as? NSDictionary)!["PreçoBaseSemana"] as! String
            if( parque == nomeParque){
                self.lblName.text = parque	
                self.nrLugaresLbl.text = nrLugares
                self.PrecoBaseSemanaLbl.text = PrecoBaseSemana
            }
            
            
            
            
            print(nomeParque + "ahahahahsh")
            print(nrLugares)
            
        })
        
       
    }
    
    

    
 
    
    
    
    
    
    
}
