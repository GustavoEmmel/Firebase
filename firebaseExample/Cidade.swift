//
//  Cidade.swift
//  tableView
//
//  Created by Felipe Malta on 26/09/16.
//  Copyright © 2016 4tap. All rights reserved.
//

import UIKit

class Cidade{
    var cod: String = ""
    var nome: String = ""
    var estado = Estado()
    
    convenience init(f_nome: String?, f_estado: Estado?) {
        self.init()
        
        self.nome = f_nome ?? ""
        self.estado  = f_estado!
    }
}

