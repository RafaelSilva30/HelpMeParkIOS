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
    
   var post: Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         lblName.text = post.lblName
        
    }
    
    

    
 
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblLongitude: UILabel!
    
    @IBOutlet weak var lblLatitude: UILabel!
    
    
    
}
