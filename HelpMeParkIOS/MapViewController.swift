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

//CUSTOM PIN

class customPin: NSObject,MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(pinTitle: String, location:CLLocationCoordinate2D, pinSub: String){
        self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSub
        
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    let manager = CLLocationManager()
    
    let ref = Database.database().reference()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerLocation = CLLocation(latitude: 12, longitude: 12)
        
        centerMapOnLocation(location: centerLocation)
        
      
        
       
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        
        ref.child("Parques").observe(.childAdded, with: { (snapshot) in
            
            let latitude = (snapshot.value as AnyObject?)!["Latitude"] as! String?
            let longitude = (snapshot.value as AnyObject?)!["Longitude"] as! String?
            
            let point = MKPointAnnotation()
            
          
            let titulo  =  (snapshot.value as AnyObject?)!["nome"] as! String?
            
            let subtitulo = (snapshot.value as AnyObject?)!["lugares"] as! String?
           
            
            let coordenadas = CLLocationCoordinate2D(latitude: (Double(latitude!))!, longitude: (Double(longitude!))!)
            
            let pin = customPin(pinTitle:"Nome: " + titulo!, location: coordenadas, pinSub: "Numero de Lugares: " + subtitulo!)
            
            self.mapa.delegate = self
            
            self.mapa.addAnnotation(pin);
            
            
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
     
        mapa.setRegion(region, animated: true)
        
        manager.stopUpdatingLocation()
       
      
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //SEGUE
    }
    
 
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
       
        let reuseIdentifier = "pin"
        
        
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            annotationView.image = UIImage(named: "mapMarker")
            annotationView.canShowCallout = true
            
       let button = UIButton(type: .detailDisclosure) as UIButton
        
        annotationView.rightCalloutAccessoryView = button
        
        
       return annotationView
        
    }
    
    
    
    
    
}

