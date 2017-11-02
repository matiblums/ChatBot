/**
 * Copyright 2017 Google Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
import UIKit
import AI

class TextRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var imgContacto: UIImageView!
    
    
    @IBOutlet weak var viewTexto: UIView!
    
    @IBOutlet weak var textField: UITextField!
    fileprivate var response: QueryResponse? = .none
    
    @IBOutlet var miTabla: UITableView? = nil
    
    var mensajes: [String] = []
    var mensajesCodigo: [Int] = []
    
    
    var keyboardSizeTotal = CGFloat(260.0)
    
    var strNombre : String = ""
    var strImagen : String = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        //textField?.becomeFirstResponder()
        //self.lblDate?.text = "últ. vez hoy a las 21:37"
        
        self.lblHora?.text = "en línea"
        /*
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(TextRequestViewController.keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(TextRequestViewController.keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
        */
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideForzado),
            name: Notification.Name("ocultaTeclado"),
            object: nil
        )
        
        self.lblHora.text = "últ. vez hoy a las 14:26"
        self.lblNombre.text = strNombre
        self.imgContacto.image = UIImage(named:strImagen)
        
        self.viewTexto.frame.origin.y = self.view.frame.size.height - self.viewTexto.frame.size.height
        self.miTabla?.frame.origin.y = 64
        self.miTabla?.frame.size.height = self.view.frame.size.height - self.viewTexto.frame.size.height - 64
 
        
        
        self.miTabla?.dataSource = self
        self.miTabla?.delegate = self
        
        self.miTabla?.estimatedRowHeight = 200.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.viewTexto.frame.origin.y -= keyboardHeight
            self.miTabla?.frame.size.height -= keyboardHeight
            subeScroll()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            //let keyboardRectangle = keyboardFrame.cgRectValue
            //let keyboardHeight = keyboardRectangle.height
            
            //self.viewTexto.frame.origin.y += keyboardHeight
            //self.miTabla?.frame.size.height += keyboardHeight
            
            self.viewTexto.frame.origin.y = self.view.frame.size.height - self.viewTexto.frame.size.height
            self.miTabla?.frame.origin.y = 64
            self.miTabla?.frame.size.height = self.view.frame.size.height - self.viewTexto.frame.size.height - 64
            
            subeScroll()
        }
    }
    
    @objc func keyboardWillHideForzado(_ notification: Notification) {
        view.endEditing(true)
        //self.miTabla?.frame.size.height = self.view.frame.size.height - self.viewTexto.frame.size.height
        //self.viewTexto.frame.origin.y = self.view.frame.size.height - self.viewTexto.frame.size.height
        
        //subeScroll()
        
        
    }
    
    /*
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.viewTexto.frame.origin.y -= keyboardSizeTotal
            self.miTabla?.frame.size.height -= keyboardSizeTotal
            subeScroll()
            //if self.view.frame.origin.y == 0{
              //  self.view.frame.origin.y -= keyboardSize.height
            //}
        }
    }
 
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.viewTexto.frame.origin.y += keyboardSizeTotal
            self.miTabla?.frame.size.height += keyboardSizeTotal
            subeScroll()
           // if self.view.frame.origin.y != 0{
           //     self.view.frame.origin.y += keyboardSize.height
           // }
        }
        
       
    }
     */
    @IBAction func tocaEsconder(_ sender: Any) {
        print("toca")
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell0"
        
        let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
        
        switch mensajesCodigo[indexPath.row] {
        case 0:
            let cellID = "Cell0"
            
            let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
            cell.txtMensaje.text = mensajes[indexPath.row]
            
            let caracteres = mensajes[indexPath.row].count
            
            if(caracteres < 30){
                
                let myString: String = mensajes[indexPath.row]
                let size: CGSize = myString.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])
                
                cell.viewBurbuja.frame.size.width = size.width + 20
                
                
            }
            else{
                cell.viewBurbuja.frame.size.width = cell.viewBack.frame.size.width + 20
            }
            
      
            return cell
        case 1:
            let cellID = "Cell1"
            
            let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
            cell.txtMensaje.text = mensajes[indexPath.row]
            
            let caracteres = mensajes[indexPath.row].count
            
            if(caracteres < 30){
                
                let myString: String = mensajes[indexPath.row]
                let size: CGSize = myString.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])
                
                cell.viewBurbuja.frame.size.width = size.width + 25
                
                
            }
            else{
                cell.viewBurbuja.frame.size.width = cell.viewBack.frame.size.width + 11
            }
            
            cell.viewBurbuja.frame.origin.x = cell.frame.size.width - cell.viewBurbuja.frame.size.width - 20
            
            return cell
        
        case 2:
            let cellID = "Cell2"
            
            let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
            
            cell.imgMensaje.image = UIImage(named:mensajes[indexPath.row])
            
            
            
            return cell
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.mensajes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("You selected cell number: \(indexPath.row)!")
        //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
        //textField?.becomeFirstResponder()
    }
    
    
 
    @IBAction func sendText(_ sender: UIButton){
       
        if(self.textField?.text != ""){
            enviaMensaje(mensaje: (self.textField?.text)!)
        }
        
    }
    
    func subeScroll(){
        
        miTabla?.reloadData()
        let numberOfSections = self.miTabla?.numberOfSections
        let numberOfRows = self.miTabla?.numberOfRows(inSection: numberOfSections!-1)
        
        let indexPath = IndexPath(row: numberOfRows!-1 , section: numberOfSections!-1)
        
        if(self.mensajes.count>0){
            self.miTabla?.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
        
    }
        
        
    func enviaMensaje(mensaje: String){
        let miMensaje = mensaje
        self.textField?.text = ""
        self.lblHora?.text = "escribiendo..."
        
        
        self.mensajes.append(miMensaje)
        self.mensajesCodigo.append(1)
        
        subeScroll()
        
        
        AI.sharedService.textRequest(miMensaje).success {[weak self] (response) -> Void in
            self?.response = response
            //var result: QueryResponse!
            DispatchQueue.main.async { [weak self] in
                
                let arrayID = response.result.fulfillment?.speech as NSString?
                //let arrayResolvedQuery = response.result.resolvedQuery as NSString?
                
                let numero = 4
                
                if((arrayID?.length)! > numero){
                    let primerosTres = arrayID!.substring(to: numero)
                    let sinPrimerosTres = arrayID!.substring(from: numero)
                    
                    if(primerosTres == "img:"){
                        self?.mensajes.append(sinPrimerosTres as String)
                        self?.mensajesCodigo.append(2)
                        
                        //self?.enviaMensaje(mensaje: arrayResolvedQuery! as String)
                        
                    }
                    else if(primerosTres == "vid:"){
                        
                    }
                    else if(primerosTres == "aud:"){
                        
                    }
                    else{
                        
                        self?.mensajes.append(arrayID! as String)
                        self?.mensajesCodigo.append(0)
                        
                    }
                }
                else{
                    self?.mensajes.append(arrayID! as String)
                    self?.mensajesCodigo.append(0)
                }
               
                
                self?.lblHora?.text = "en línea"
                self?.subeScroll()
                
            }
            }.failure { (error) -> Void in
                
                self.mensajes.append("error")
                self.mensajesCodigo.append(0)
                
                /*
                
                DispatchQueue.main.async {
                    
                    
                    let alert = UIAlertController(
                        title: "Error",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(
                        UIAlertAction(
                            title: "Cancel",
                            style: .cancel,
                            handler: .none
                        )
                    )
                    
                    self.present(
                        alert,
                        animated: true,
                        completion: .none
                    )
 
 
                }
 
             */
        }
        
        
    }
    
}
