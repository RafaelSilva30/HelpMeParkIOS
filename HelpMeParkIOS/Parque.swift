//
//  Parque.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 07/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import  UIKit
import MapKit

class Parque: NSObject{
    
    var nomeParque: String = ""
    var distancia: Double?
   

    
    init(nome: String, distancia: Double? = nil) {
        self.distancia = distancia
        self.nomeParque = nome
        

        
    }
}

