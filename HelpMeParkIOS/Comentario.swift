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
    var nome : String = ""
    let reff = Database.database().reference()
    
     var dbHandle: DatabaseHandle?
    

    @IBOutlet weak var nomeParque: UILabel!
    @IBOutlet weak var nomeUserComent: UILabel!
    @IBOutlet weak var dataComent: UILabel!
    
    @IBOutlet weak var dispComent: CosmosView!
    
    
    
    
    
    var parque: String = ""
    var ParqueList: String = ""
    
    @IBOutlet weak var ratingBar: CosmosView!
    
    
    @IBOutlet weak var observacoes: UITextView!
    
    
    @IBOutlet weak var ratingcoment: UILabel!
    
    @IBOutlet weak var coment_obs: UITextView!
    
    @IBOutlet weak var dataAtual: UILabel!
    
    @IBOutlet weak var lblRatingBar: UILabel!
    
    @IBOutlet weak var nomeUserAtual: UILabel!
    override func viewDidLoad() {
        
        
        let email = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        
        let teste =  reff.child("Users").child(uid!)
        print("vivvaaa")
        print(teste)
        
        dbHandle = teste.observe(.value,  with:{(snapshot) in
            let nomeUser:String? = snapshot.childSnapshot(forPath:"Username").value as? String
            let emailUser:String? = snapshot.childSnapshot(forPath:"email").value as? String
            
            print(emailUser)
            print(email)
            if emailUser == email {
                print("ENTREI AQUI MPT")
                self.nome = nomeUser!
                print(self.nomeUserAtual.text)
            }
        })
        
        nomeParque.text = parque
        
        let refff =  Database.database().reference().child("Parques").child(ParqueList)
        print("PRINT LIST")
        
        
        dbHandle = refff.child("comentario").observe(.value,  with:{(snapshot) in
            let nomeUser:String? = snapshot.childSnapshot(forPath:"nomeUser").value as? String
           
            self.nomeUserComent.text = (nomeUser)
            
            let data:String? = snapshot.childSnapshot(forPath:"data").value as? String
            
            self.dataComent.text = (data)
            
            let disponibilidade:Double? = snapshot.childSnapshot(forPath:"disponibilidade").value as? Double
            
            self.dispComent.rating = Double(disponibilidade!) as! Double
            
            
            
            let text_coment:String? = snapshot.childSnapshot(forPath:"text_Coment").value as? String
        
            self.observacoes.text = (text_coment)
            
            
            self.dispComent.settings.starSize = 27
            
            valor()
            avaliar()
            
            //self.lblRatingBar.sizeToFit()
            
        })
        
        self.ratingBar.settings.starSize = 27
        
        
        func avaliar(){
            
            ratingBar.didTouchCosmos = {rating in
                
                
                switch self.ratingBar.rating {
                case 1:
                    self.lblRatingBar.text = "Parque Vazio"
                    
                case 2:
                     self.lblRatingBar.text = "Quase Vazio"
                case 3:
                     self.lblRatingBar.text = "Meio Cheio"
                case 4:
                     self.lblRatingBar.text = "Parque quase cheio"
                case 5:
                     self.lblRatingBar.text = "Parque Cheio"
                    
                default:
                    self.lblRatingBar.text = ""
                }
            }
        }
        
        
        func valor(){
            switch self.dispComent.rating {
            case 1:
                self.ratingcoment.text = "Parque Vazio"
                
            case 2:
                self.ratingcoment.text = "Quase Vazio"
            case 3:
                self.ratingcoment.text = "Meio Cheio"
            case 4:
                self.ratingcoment.text = "Parque quase cheio"
            case 5:
                self.ratingcoment.text = "Parque Cheio"
                
            default:
                self.ratingcoment.text = ""
            }
            
            
        }
        
        
        getCurrentDateTime()
        let teste1 = parque
        print(parque)
    }
    
    
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let str = formatter.string(from: Date())
        self.dataAtual.text = str
        
    }
    
    
    
    @IBAction func addComentario(_ sender: Any) {

       
        let data1 = ["disponibilidade":ratingBar.rating  ,"nomeUser": nome, "text_Coment": coment_obs.text!, "data": dataAtual.text!] as [String : Any]
        
        self.reff.child("Parques").child(parque).child("comentario").setValue(data1)
        }
}
