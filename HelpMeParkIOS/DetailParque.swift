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
    
    var parquesList: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(parquesList)
        let parque = parquesList
        print(parque)
        lblName.text = parque
        
        
        
        
    }
    
    

    
 
    
    
    
    
    
    
}
