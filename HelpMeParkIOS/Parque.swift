//
//  Parque.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 07/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import  UIKit

class Parque: NSObject {
    
    var nomeParque: String = ""
    var nrLugares: String = ""
    
    
    init(nome: String, lugares: String) {
        
        self.nomeParque = nome
        self.nrLugares = lugares
        
    }
}

