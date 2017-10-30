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

class TextRequestViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    fileprivate var response: QueryResponse? = .none
    @IBOutlet var lblRespuesta: UILabel? = nil
    @IBOutlet var lblDate: UILabel? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField?.becomeFirstResponder()
        //self.lblDate?.text = "últ. vez hoy a las 21:37"
        
        self.lblDate?.text = "en línea"
    }
    
    
    
    @IBAction func sendText(_ sender: UIButton)
    {
       
        
       // self.textField?.text = ""
        self.lblRespuesta?.text = ""
        self.lblDate?.text = "escribiendo..."
        
        AI.sharedService.textRequest(textField.text ?? "").success {[weak self] (response) -> Void in
            self?.response = response
            //var result: QueryResponse!
            DispatchQueue.main.async { [weak self] in
                
               // if let sself = self {
                  //  print(response.result.fulfillment?.speech)
                    
                let arrayID = response.result.fulfillment?.speech as NSString?
                    
                self?.lblRespuesta?.text = arrayID! as String
                self?.lblDate?.text = "en línea"
                //}
                
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
