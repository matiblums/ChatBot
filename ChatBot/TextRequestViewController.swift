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
            /*
            let demoView = Bubles(frame: CGRect(x: 5,
                                                y: 5,
                                                width: cell.txtMensaje.frame.size.width + 5,
                                                height: cell.txtMensaje.frame.size.height + 5))
            
            cell.addSubview(demoView)
            */
            
            
            return cell
        case 1:
            let cellID = "Cell1"
            
            let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
            cell.txtMensaje.text = mensajes[indexPath.row]
            
           cell.updateConstraintsIfNeeded()
            cell.setNeedsUpdateConstraints()
            
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
    
    
 
    @IBAction func sendText(_ sender: UIButton)
    {
       
        if(self.textField?.text != ""){
            enviaMensaje()
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
        
        
    func enviaMensaje(){
        let miMensaje = self.textField?.text
        self.textField?.text = ""
        self.lblHora?.text = "escribiendo..."
        
        
        self.mensajes.append(miMensaje!)
        self.mensajesCodigo.append(1)
        
        subeScroll()
        
        
        AI.sharedService.textRequest(miMensaje ?? "").success {[weak self] (response) -> Void in
            self?.response = response
            //var result: QueryResponse!
            DispatchQueue.main.async { [weak self] in
                
                let arrayID = response.result.fulfillment?.speech as NSString?
                
                
                
                self?.mensajes.append(arrayID! as String)
                self?.mensajesCodigo.append(0)
                // if let sself = self {
                //  print(response.result.fulfillment?.speech)
                
                
                self?.lblHora?.text = "en línea"
                //}
                
                self?.subeScroll()
            }
            }.failure { (error) -> Void in
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
        }
    }
}
