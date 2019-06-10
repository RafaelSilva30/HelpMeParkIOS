//
//  CustomPin.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 10/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import MapKit

class CustomPin: NSObject,MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, location:CLLocationCoordinate2D, pinSub: String){
        self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSub
        
    }
   
}
