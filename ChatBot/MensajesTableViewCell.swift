//
//  MensajesTableViewCell.swift
//  ChatBot
//
//  Created by Matias Blum on 29/10/17.
//  Copyright © 2017 Kuragin Dmitriy. All rights reserved.
//

import UIKit

class MensajesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtMensaje: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewBurbuja: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sizeToFit()
        layoutIfNeeded()
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
