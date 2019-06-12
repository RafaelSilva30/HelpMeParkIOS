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
    
    
    @IBOutlet weak var auxLat: UILabel!
    
    @IBOutlet weak var auxLong: UILabel!
    
    
    let manager = CLLocationManager()
    
    
    
    let ref = Database.database().reference()
    
    let reff = Database.database().reference()
    
    var nomeP: String = ""
    
    var coordenadas = CLLocationCoordinate2D()
    
    var utilizador: String = ""
    
    var mapaPin: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        print(utilizador)
        
        let centerLocation = CLLocation(latitude: 12, longitude: 12)
        
        
        
        verificacaoTabBar()
        
       
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        
        ref.child("Parques").observe(.childAdded, with: { (snapshot) in
            
            let latitude = (snapshot.value as AnyObject?)!["Latitude"] as! String?
            let longitude = (snapshot.value as AnyObject?)!["Longitude"] as! String?
            
            
          
            let titulo  =  (snapshot.value as AnyObject?)!["nome"] as! String?
            
            let subtitulo = (snapshot.value as AnyObject?)!["lugares"] as! String?
           
            
            let coordenadas = CLLocationCoordinate2D(latitude: (Double(latitude!))!, longitude: (Double(longitude!))!)
            
            let pin = customPin(pinTitle:titulo!, location: coordenadas, pinSub: "Numero de Lugares: " + subtitulo!)
            
            
            
            self.mapa.delegate = self
            
            self.mapa.addAnnotation(pin);
            
            
            
            self.centerMapOnLocation(location: centerLocation)
            
            
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
    
    
    
 
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
            let anno = view.annotation as! customPin
            print(anno.title)
            // then access the properties of anno and use them for the segue
            
            nomeP = anno.title!
            print(nomeP)
            self.performSegue(withIdentifier:"pinDetalhe",sender: anno)
        
       
        
        
        
       
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pinDetalhe" {
            
            let des = segue.destination as! DetailParque
            des.parquesList = nomeP
            des.utilizador = utilizador
            
        }
        
    
    
    }

    
    
    
   
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print(self.mapaPin)
        if(self.mapaPin == "True"){
            
            let reuseIdentifier = "pin"
            
            print(mapaPin)
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            annotationView.image = UIImage(named: "blueDott")
            annotationView.canShowCallout = true
            
           
            
            
             return annotationView
            
            
        }else{
            
            self.mapaPin = "False"
            let reuseIdentifier = "pin"
            
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            annotationView.image = UIImage(named: "mapMarker")
            annotationView.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure) as UIButton
            
            annotationView.rightCalloutAccessoryView = button
            
            return annotationView
            
        }
       
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
          
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
            self.mapa.setRegion(region, animated: true)
            
            self.coordenadas = center
            
            print(coordenadas)
            
            
            
            let uid = (Auth.auth().currentUser?.uid)!
            
            let ref = Database.database().reference().child("Users").child(uid)
            
            self.auxLat.text = String(format:"%.7f", self.coordenadas.latitude)
            
            self.auxLong.text = String(format:"%.7f", self.coordenadas.longitude)
            
            let data1 = ["latitude": auxLat.text, "longitude": auxLong.text]
            self.reff.child("Users").child(uid).child("latestLoc").setValue(data1)
            
            self.mapa.showsUserLocation = true
            
           
            
            self.mapaPin = "True"
            
            
            print(self.mapaPin)
        }
    }
    
    //Verificação da TabBar
    func verificacaoTabBar(){
        if(utilizador == "convidado" || utilizador == "user"){
            if let tabBarController = self.tabBarController {
                let indexToRemove = 2
                if indexToRemove < tabBarController.viewControllers!.count {
                    var viewControllers = tabBarController.viewControllers
                    viewControllers?.remove(at: indexToRemove)
                    tabBarController.viewControllers = viewControllers
                }
            }
        }
    }
    
  
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            //  Present the login controller
            let messageVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let MynavController = UINavigationController(rootViewController: messageVC)
            self.present(MynavController, animated: true, completion: nil)
            
        } catch let signOutErr {
            print("Failed to sign out:", signOutErr)
        }
    
    
    }
    
    
    
    
    
}


