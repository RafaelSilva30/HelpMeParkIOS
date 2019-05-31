//
//  MapViewController.swift
//  HelpMeParkIOS
//
//  Created by Tiago Lopes Carvalhido on 31/05/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerLocation = CLLocation(latitude:41.69323, longitude: -8.83287)
        
        centerMapOnLocation(location: centerLocation)
        
        
    }
    
    
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    
    
}

