//
//  Estado.swift
//  tableView
//
//  Created by Felipe Malta on 26/09/16.
//  Copyright © 2016 4tap. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class Estado{

    var nome: String = ""
    var sigla: String = ""
    var arrayCidades = [Cidade]()
    
    convenience init(f_nome: String?, f_sigla: String?) {
        self.init()
        
        self.nome = f_nome ?? ""
        self.sigla = f_sigla ?? ""
        
    }
    
    
    convenience init?(_ dict: FIRDataSnapshot){
        
        self.init()
        
              
    }

}
