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
    
    
    @IBOutlet weak var viewTexto: UIView!
    
    @IBOutlet weak var textField: UITextField!
    fileprivate var response: QueryResponse? = .none
    @IBOutlet var lblDate: UILabel? = nil
    
    @IBOutlet var miTabla: UITableView? = nil
    
    var mensajes: [String] = []
    
    var keyboardSizeTotal = CGFloat(260.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //textField?.becomeFirstResponder()
        //self.lblDate?.text = "últ. vez hoy a las 21:37"
        
        self.lblDate?.text = "en línea"
        
        NotificationCenter.default.addObserver(self, selector: #selector(TextRequestViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextRequestViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
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
    
    @IBAction func tocaEsconder(_ sender: Any) {
        print("toca")
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"
        
        let cell:MensajesTableViewCell = self.miTabla!.dequeueReusableCell(withIdentifier: cellID) as! MensajesTableViewCell
        
        cell.txtMensaje.text = mensajes[indexPath.row]
        
        
        return cell
        
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
        self.lblDate?.text = "escribiendo..."
        
        
        self.mensajes.append(miMensaje!)
        
        
        subeScroll()
        
        
        AI.sharedService.textRequest(miMensaje ?? "").success {[weak self] (response) -> Void in
            self?.response = response
            //var result: QueryResponse!
            DispatchQueue.main.async { [weak self] in
                
                let arrayID = response.result.fulfillment?.speech as NSString?
                
                
                
                self?.mensajes.append(arrayID! as String)
                
                // if let sself = self {
                //  print(response.result.fulfillment?.speech)
                
                
                self?.lblDate?.text = "en línea"
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
