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
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var nrLugaresLbl: UILabel!
    
    @IBOutlet weak var PrecoBaseSemanaLbl: UILabel!
    @IBOutlet weak var Preco15MinutosLbl: UILabel!
    
    
    @IBOutlet weak var PrecoBaseFdsLbl: UILabel!
    @IBOutlet weak var Preco15MinutosFdsLbl: UILabel!
    var parquesList: String = ""
    
    let ref = Database.database().reference()
    
    var databaseHandle:DatabaseHandle?
    
    
    var ann:customPin!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let parque = parquesList
        print(parque)
        
        
        
        ref.child("Parques").observe(.childAdded,    with: {
            snapshot in
            
            
            let nomeParque = (snapshot.value as? NSDictionary)!["nome"] as! String
            let nrLugares = (snapshot.value as? NSDictionary)!["lugares"] as! String
            let PrecoBaseSemana = (snapshot.value as? NSDictionary)!["PreçoBaseSemana"] as! String
            let Preco15Minutos = (snapshot.value as? NSDictionary)!["Preço15MinutosSemana"] as! String
            
            let PrecoBaseFds = (snapshot.value as? NSDictionary)!["PreçoBaseFimdeSemana"] as! String
            let Preco15MinutosFds = (snapshot.value as? NSDictionary)!["Preço15MinutosFimdeSemana"] as! String
            
            if( parque == nomeParque){
                self.lblName.text = parque	
                self.nrLugaresLbl.text = nrLugares
                self.PrecoBaseSemanaLbl.text = PrecoBaseSemana
                self.Preco15MinutosLbl.text = Preco15Minutos
                self.PrecoBaseFdsLbl.text = PrecoBaseFds
                self.Preco15MinutosFdsLbl.text = Preco15MinutosFds
                
               
            }
        })
        
       
    }
    
    
    
    @IBAction func addComentario(_ sender: Any) {
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ComentarioSegue"
        {
           let comentario = (segue.destination as! Comentario)
            comentario.parque = lblName.text!
        }
    }
    
}
