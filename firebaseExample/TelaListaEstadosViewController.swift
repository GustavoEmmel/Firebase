//
//  TelaListaEstadosViewController.swift
//  firebaseExample
//
//  Created by Felipe Malta on 06/12/16.
//  Copyright © 2016 Felipe Malta. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import APESuperHUD
class TelaListaEstadosViewController: UIViewController {

    var arrayCidades = [Cidade]()
    
    @IBOutlet weak var viewCadastro: UIStackView!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtSigla: UITextField!
    @IBOutlet weak var txtNomeEstado: UITextField!
    @IBOutlet weak var tableCidades: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCadastro.isHidden = true
        
        self.loadEstados()
               // Do any additional setup after loading the view.
    }
    
    func loadEstados()-> Void{
    
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Carregando informações", presentingView: self.view)
        
        FIRDatabase.database().reference().child("cidades").observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.hasChildren() else{
                
                APESuperHUD.showOrUpdateHUD(icon: .sadFace, message: "Nenhum dado disponível", duration: 2.0, presentingView: self.view, completion: nil)
                return}
            
            self.arrayCidades.removeAll()
            
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                
                    let estadoAux = Estado()
                    let cidadeAux = Cidade()
                
                    let objJson = JSON(rest.value ?? "")
                    
                    cidadeAux.cod = rest.key
                    
                    if let nome = objJson["cidade"].string{
                        cidadeAux.nome = nome
                        
                    }
                
                    if let estado = objJson["estado"].string{
                    
                        estadoAux.sigla = estado
                    }

                
                    if let sigla = objJson["sigla"].string{
                        
                        estadoAux.sigla = sigla
                    }
                
                    cidadeAux.estado = estadoAux
                
                    self.arrayCidades.append(cidadeAux)

            }
            
            APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            self.tableCidades.reloadData()
        })    
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        
        do {
            try FIRAuth.auth()!.signOut()
        } catch (let error) {
            print(error)
        }
    }

    @IBAction func btnAdd(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.viewCadastro.isHidden == true {
                self.viewCadastro.isHidden = false
            }else{
                self.viewCadastro.isHidden = true
            }
        })
        
        
    }
    @IBAction func btnSalvar(_ sender: Any) {
        
        let key = FIRDatabase.database().reference().child("cidades").childByAutoId().key
        let estado = ["cidade": self.txtCidade.text ?? "","estado": self.txtNomeEstado.text ?? "", "sigla": self.txtSigla.text ?? ""]
        
        let childUpdates = ["/cidades/\(key)": estado]
        FIRDatabase.database().reference().updateChildValues(childUpdates){ (error, ref) -> Void in
            if error != nil {
                
                  APESuperHUD.showOrUpdateHUD(icon: .sadFace, message: "Erro ao salvar a Cidade", duration: 2.0, presentingView: self.view, completion: nil)
                
            }else{
                
                self.txtCidade.text = ""
                self.txtNomeEstado.text = ""
                self.txtSigla.text = ""
                self.loadEstados()
            }
        }

    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TelaListaEstadosViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCidades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCidade", for: indexPath)
        
        cell.textLabel?.text = self.arrayCidades[indexPath.row].nome
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
        
            FIRDatabase.database().reference().child("cidades").child(self.arrayCidades[indexPath.row].cod).removeValue(){ (error, ref) -> Void in
                if error != nil {
                    
                }else{
                    self.arrayCidades.remove(at: indexPath.row)
                    self.tableCidades.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}



