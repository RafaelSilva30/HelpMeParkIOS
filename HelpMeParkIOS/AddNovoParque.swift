import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import GeoFire

class AddNovoParque: UIViewController,UITextFieldDelegate  {
    
    
   //Preço Base var
    @IBOutlet weak var preçoBaseSemana: UITextField!
    @IBOutlet weak var precoBaseFds: UITextField!
    
    //Preço 15 minutos var
    
    @IBOutlet weak var preco15minSemana: UITextField!
    @IBOutlet weak var preco15minfds: UITextField!
    
    
    @IBOutlet weak var lugares: UITextField!
    
    @IBOutlet weak var nome: UITextField!
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    
    var ref: DatabaseReference!

    let reff = Database.database().reference()
    var disp : Double = 0.0
    
   
    
    override func viewDidLoad() {
      
    
        super.viewDidLoad()
        
        
        

    }
    
    
    
    @IBAction func addParque(_ sender: Any) {
        
        let data = ["nome": nome.text!,"lugares": lugares.text!, "Latitude": latitude.text!, "Longitude": longitude.text!,"PreçoBaseSemana":preçoBaseSemana.text!,"Preço15MinutosSemana":preco15minSemana.text!,"PreçoBaseFimdeSemana":precoBaseFds.text!,"Preço15MinutosFimdeSemana":preco15minfds.text!]
        
        let data2 = ["data": "","disponibilidade" : disp, "nomeUser": "", "text_Coment": "Ainda sem comentário."] as [String : Any]
        
        
        self.reff.child("Parques").child(nome.text!).setValue(data)
        
            self.reff.child("Parques").child(nome.text!).child("comentario").setValue(data2)
        
        
    
    }
        
    
    
    
    
    
}
