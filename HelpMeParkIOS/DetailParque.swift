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
    
    var nome = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      lblName.text! = nome
        
        
        
    }
    
    

    
 
    
    
    
    
    
    
}
