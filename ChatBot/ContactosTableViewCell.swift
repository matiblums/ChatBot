//
//  ContactosTableViewCell.swift
//  ChatBot
//
//  Created by Matias Blum on 30/10/17.
//  Copyright © 2017 Kuragin Dmitriy. All rights reserved.
//

import UIKit

class ContactosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var imgContacto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
