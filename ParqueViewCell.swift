//
//  ParqueViewCell.swift
//  
//
//  Created by Tiago Lopes Carvalhido on 07/06/2019.
//

import UIKit

class ParqueViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var distancia: UILabel!
    
}
