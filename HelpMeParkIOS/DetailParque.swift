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
import Cosmos


class DetailParque: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var nrLugaresLbl: UILabel!
    
    @IBOutlet weak var PrecoBaseSemanaLbl: UILabel!
    @IBOutlet weak var Preco15MinutosLbl: UILabel!
    
    @IBOutlet weak var nomeUserComent: UILabel!
    
    @IBOutlet weak var ratingComent: CosmosView!
    @IBOutlet weak var dataComent: UILabel!
    
    @IBOutlet weak var obsComent: UITextView!
    
    @IBOutlet weak var PrecoBaseFdsLbl: UILabel!
    @IBOutlet weak var Preco15MinutosFdsLbl: UILabel!
    var parquesList: String = ""
    
    
    
    @IBOutlet weak var levelParque: UILabel!
    
    let ref = Database.database().reference()
    let reff = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?
    
    
    var ann:customPin!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let parque = parquesList
        print(parque)
        
        lblName.sizeToFit()
        
        
        ref.child("Parques").observe(.childAdded,    with: {
            snapshot in
            
            
            let nomeParque = (snapshot.value as? NSDictionary)!["nome"] as! String
            let PrecoBaseSemana = (snapshot.value as? NSDictionary)!["PreçoBaseSemana"] as! String
            let Preco15Minutos = (snapshot.value as? NSDictionary)!["Preço15MinutosSemana"] as! String
            
            let PrecoBaseFds = (snapshot.value as? NSDictionary)!["PreçoBaseFimdeSemana"] as! String
            let Preco15MinutosFds = (snapshot.value as? NSDictionary)!["Preço15MinutosFimdeSemana"] as! String

                self.lblName.text = parque	
                
                self.PrecoBaseSemanaLbl.text  = PrecoBaseSemana + "€"
                self.Preco15MinutosLbl.text = Preco15Minutos + "€"
                self.PrecoBaseFdsLbl.text = PrecoBaseFds + "€"
                self.Preco15MinutosFdsLbl.text = Preco15MinutosFds + "€"
            
               
            
        })
        
        
        let refff =  Database.database().reference().child("Parques").child(parque)
        print("PRINT LIST")
        
        
        databaseHandle = refff.child("comentario").observe(.value,  with:{(snapshot) in
            
            let nomeUser:String? = snapshot.childSnapshot(forPath:"nomeUser").value as? String
            
            let dataComent:String? = snapshot.childSnapshot(forPath:"data").value as? String
            
            let disponibilidade:Double? = snapshot.childSnapshot(forPath:"disponibilidade").value as? Double
            
            let obsComent:String? = snapshot.childSnapshot(forPath:"text_Coment").value as? String
            
            
            self.obsComent.text = obsComent
            
            self.ratingComent.rating = Double(disponibilidade!) as! Double
            
            self.nomeUserComent.text = nomeUser
            self.dataComent.text = dataComent
            
            
            valor()
        
        })
        
        self.ratingComent.settings.starSize = 27
        
        
        
        func valor(){
            switch self.ratingComent.rating {
            case 1:
                self.levelParque.text = "Parque Vazio"
                
            case 2:
                self.levelParque.text = "Quase Vazio"
            case 3:
                self.levelParque.text = "Meio Cheio"
            case 4:
                self.levelParque.text = "Parque quase cheio"
            case 5:
                self.levelParque.text = "Parque Cheio"
                
            default:
                self.levelParque.text = ""
            }
            
            
        }
        
        
        
    }
    
    
    
    @IBAction func addComentario(_ sender: Any) {
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ComentarioSegue"
        {
           let comentario = (segue.destination as! Comentario)
            comentario.parque = lblName.text!
            comentario.ParqueList = parquesList
        }
    }
    
}
