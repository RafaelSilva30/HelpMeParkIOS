//
//  Parques.swift
//  HelpMeParkIOS
//
//  Created by Rafael Silva on 04/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit
import MapKit
import FirebaseAuth

class Parques: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    var parquesList = [Parque]()
    
    var coordenadas = [CLLocation]()
    
    var currentLoc = CLLocation()
    
    var distancias: [Float] = []
    
    
    var selectedLabel:String?
    var utilizador: String = ""
    var doubleToString: String = ""
    
    var closestLocation: CLLocation?
    
    var smallestDistance: CLLocationDistance?
    
    
    var dbHandle: DatabaseHandle?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return parquesList.count
        
        
    }
    
    

    
    
    @IBOutlet weak var nrlugares: UILabel!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParqueViewCell
      
    
        cell.lblName.text! = parquesList[indexPath.row].nomeParque
        
            
        //Label do Nome
        cell.lblName.font = UIFont(name: "Arial-BoldMT", size:30);
        cell.lblName.textColor = UIColor.white
        cell.lblName.sizeToFit()
        
       

        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
       
        cell.backgroundView = UIImageView(image: UIImage(named: "table"))
       
        cell.tintColor = UIColor.white
 
     
       
    
        return cell
        
    }
    
    
    
 
    
    
   func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    let alert = UIAlertController(title: "Informações", message:"Nome do Parque: " + parquesList[indexPath.row].nomeParque + "\n" + "\n" + " Distancia à sua localizacao: " + String(format:"%.2f",distancias[indexPath.row]) + " KM", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
        alert.view.tintColor = UIColor.red;
    
   
    }
    
    
    
   
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(parquesList[indexPath.row].nomeParque)
        self.performSegue(withIdentifier: "detalheParque", sender: indexPath)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheParque" {
            let idx = sender as! IndexPath
            let vcdetalhe = (segue.destination as! DetailParque)
            vcdetalhe.parquesList = parquesList[idx.row].nomeParque
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

    


    //SET FIREBASE REFERENCE
    let ref = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?

    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        print(utilizador)

        tableView.delegate = self
            

            tableView.backgroundView = UIImageView(image: UIImage(named: "table"))
    
            ref.child("Parques").observe(.childAdded,    with: {
                snapshot in
                
                print(snapshot)
       
                let nome = (snapshot.value as? NSDictionary)!["nome"] as! String
                
                let auxLat = (snapshot.value as? NSDictionary)!["Latitude"] as! String
                
                let auxLong = (snapshot.value as? NSDictionary)!["Longitude"] as! String
                
                let latitude = Double(auxLat)
                let longitude = Double(auxLong)
                
                self.parquesList.append(Parque(nome: nome))
                
                self.coordenadas.append(CLLocation(latitude: Double(auxLat) as! CLLocationDegrees, longitude: Double(auxLong) as! CLLocationDegrees))
                
    
                
            })
    
      
        let uid = (Auth.auth().currentUser?.uid)!
       
        dbHandle = ref.child("Users").child(uid).child("latestLoc").observe(.value, with: {
            (snapshot) in
            
            
            let currentLat = snapshot.childSnapshot(forPath:"latitude").value as? String
           
            let currentLng = snapshot.childSnapshot(forPath:"longitude").value as? String
     
            self.currentLoc = CLLocation(latitude: Double(currentLat!) as! CLLocationDegrees, longitude: Double(currentLng!) as! CLLocationDegrees)

            for location in self.coordenadas {
                print("Locations")
                print(location)
                
                
                
                let distance = (self.currentLoc.distance(from: location))
                
                
                print("Distancias")
                

                self.distancias.append(Float((distance) / 1000))
                
                
                
              self.distancias.sort() { $0.distance(to: Float(distance)) > $1.distance(to: Float(distance))}
               
               
                self.tableView.reloadData()
                
               
            }
          
        })
        
        
    }
 
 

}



    






