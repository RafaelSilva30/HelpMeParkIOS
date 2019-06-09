//
//  ParqueClass.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 08/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import UIKit
import Firebase


struct ParqueModel {
    
    var nomeParque: String!
    var ref: DatabaseReference!
    
    
    init( nomeParque: String){
        
        self.nomeParque = nomeParque
        
        self.ref = Database.database().reference()
        
    }
    
    
    init(snapshot: DataSnapshot){
        
        self.nomeParque = (snapshot.value as! NSDictionary)["NomeParque"] as? String
        self.ref = snapshot.ref
        
    }
   
} 
    
   
   

