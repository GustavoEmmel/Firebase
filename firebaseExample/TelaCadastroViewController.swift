//
//  TelaCadastroViewController.swift
//  firebaseExample
//
//  Created by Felipe Malta on 06/12/16.
//  Copyright © 2016 Felipe Malta. All rights reserved.
//

import UIKit
import Firebase
import APESuperHUD

class TelaCadastroViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!

    @IBOutlet weak var txtSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCadastro(_ sender: Any) {
   
        FIRAuth.auth()?.createUser(withEmail: self.txtEmail.text!, password: self.txtSenha.text!, completion: { (auth, error) in
            if let error = error {
                
            APESuperHUD.showOrUpdateHUD(icon: .sadFace, message: "Erro", duration: 3.0, presentingView: self.view, completion:nil)
                
                print("Deu erro:\(error)")
            } else {
                print("Criou o user")
                
                self.dismiss(animated: true, completion: nil)
                // No user is signed in.
            }
        })
    }

    @IBAction func btnEntrar(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
