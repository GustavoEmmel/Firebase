//
//  ViewController.swift
//  firebaseExample
//
//  Created by Felipe Malta on 06/12/16.
//  Copyright © 2016 Felipe Malta. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var arrayCapas = ["https://s-media-cache-ak0.pinimg.com/236x/bf/0d/8b/bf0d8b0224fcb5bfa05b7b3e1a9790b1.jpg","https://s-media-cache-ak0.pinimg.com/236x/91/04/e8/9104e8dd00d53c4c895123171faf22d5.jpg","https://http2.mlstatic.com/livro-trilogia-o-senhor-dos-aneis-capas-ilustraco-tolkien-D_NQ_NP_14865-MLB20092294070_052014-F.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                    let key = FIRDatabase.database().reference().child("estados").childByAutoId().key
                    let estado = ["nome": "Rio Grande do Sul", "sigla": "RS"]
        
                    let childUpdates = ["/estados/\(key)": estado]
        
                    FIRDatabase.database().reference().updateChildValues(childUpdates)
                    let key2 = FIRDatabase.database().reference().child("estados").child(key).child("cidades").childByAutoId().key
        
                    let cidade = ["nome": "Canoas"]
        
                    let childUpdates2 = ["/estados/\(key)/cidades/\(key2)": cidade]
                    FIRDatabase.database().reference().updateChildValues(childUpdates2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

