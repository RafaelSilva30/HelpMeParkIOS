//
//  Comentario.swift
//  HelpMeParkIOS
//
//  Created by Rafael Silva on 09/06/2019.
//  Copyright © 2019 Alvaro. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit
import Cosmos
import FirebaseAuth

class Comentario: UIViewController {

    var ref: DatabaseReference!
    
    let reff = Database.database().reference()
    
    

    @IBOutlet weak var nomeUserComent: UILabel!
    @IBOutlet weak var dataComent: UILabel!
    
    @IBOutlet weak var dispComent: CosmosView!
    
    @IBOutlet weak var obsComent: UILabel!
    
    
    var parque: String = ""
    var ParqueList: String = ""
    
    @IBOutlet weak var ratingBar: CosmosView!
    
    @IBOutlet weak var obsvacoes: UITextField!
    
    @IBOutlet weak var dataAtual: UILabel!
    override func viewDidLoad() {
        let refff =  Database.database().reference().child("Parques").child(ParqueList)
        print("PRINT LIST")
        print(ParqueList)

        
        
        getCurrentDateTime()
           let teste = parque
        print(parque)
    }
    @IBOutlet weak var nomeUserAtual: UILabel!
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let str = formatter.string(from: Date())
        self.dataAtual.text = str
        
    }
    @IBAction func addComentario(_ sender: Any) {
    let email = Auth.auth().currentUser?.email
    self.nomeUserAtual.text = email

        
       
        let data1 = ["disponibilidade": ratingBar.rating,"nomeUser": nomeUserAtual.text!, "text_Coment": obsvacoes.text!, "data": dataAtual.text!] as [String : Any]
        
        self.reff.child("Parques").child(parque).child("comentario").setValue(data1)
        }
}
