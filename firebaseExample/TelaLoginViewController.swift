//
//  TelaLoginViewController.swift
//  firebaseExample
//
//  Created by Felipe Malta on 06/12/16.
//  Copyright © 2016 Felipe Malta. All rights reserved.
//

import UIKit
import Firebase
import APESuperHUD

class TelaLoginViewController: UIViewController {

    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRedefinirSenha(_ sender: Any) {
        
        let email = self.txtEmail.text
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email!) { error in
            if error != nil {
                APESuperHUD.showOrUpdateHUD(icon: .sadFace, message: "Erro ao redefinir senha", duration: 3.0, presentingView: self.view, completion:nil)
            } else {
                APESuperHUD.showOrUpdateHUD(icon: .email, message: "E-mail com redefinição da senha enviado", duration: 3.0, presentingView: self.view, completion:nil)
                
            }
        }

        
    }
    @IBAction func btnEntrar(_ sender: Any) {
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Realizando Login", presentingView: self.view)
        
        
        FIRAuth.auth()?.signIn(withEmail: self.txtEmail.text!, password: self.txtSenha.text!) { (user, error) in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
                
            }else{
                
                APESuperHUD.showOrUpdateHUD(icon: .sadFace, message: "Erro", duration: 3.0, presentingView: self.view, completion:nil)
            }
        }
        
    }

    @IBAction func btnRegistrar(_ sender: Any) {
  
        self.performSegue(withIdentifier: "segueCadastro", sender: self)
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
