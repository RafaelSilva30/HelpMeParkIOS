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
import CoreLocation
import GeoFire

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    let manager = CLLocationManager()
    
    let ref = Database.database().reference()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerLocation = CLLocation(latitude:41.69323, longitude: -8.83287)
        
        centerMapOnLocation(location: centerLocation)
        
       
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        ref.child("Parques").observe(.childAdded, with: { (snapshot) in
            
            let latitude = (snapshot.value as AnyObject?)!["Latitude"] as! String?
            let longitude = (snapshot.value as AnyObject?)!["Longitude"] as! String?
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: (Double(latitude!))!, longitude: (Double(longitude!))!)
            
            annotation.title = (snapshot.value as AnyObject?)!["Latitude"] as! String?
            	
            self.mapa.addAnnotation(annotation)
        })
        
       
        
    }
    
   
        
    
    
    
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 7000000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    @IBAction func receberLocalizacao(_ sender: Any) {
        manager.startUpdatingLocation()
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
      //  let annotation = MKPointAnnotation()
      // annotation.coordinate = location.coordinate
        mapa.setRegion(region, animated: true)
       // self.mapa.addAnnotation(annotation)
        
        manager.stopUpdatingLocation()
       
      
    }
    
    
    
    
    
}

