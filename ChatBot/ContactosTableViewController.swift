//
//  ContactosTableViewController.swift
//  ChatBot
//
//  Created by Matias Blum on 30/10/17.
//  Copyright © 2017 Kuragin Dmitriy. All rights reserved.
//

import UIKit

class ContactosTableViewController: UITableViewController {

    
    
    var mensajes: [String] = ["No estoy enterado del tema"]
    var nombre: [String] = ["Maurico Macri"]
    var hora: [String] = ["21:35"]
    var imagen: [String] = ["macrismo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mensajes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"
        
        let cell:ContactosTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellID) as! ContactosTableViewCell
        
        cell.lblHora.text = hora[indexPath.row]
        cell.lblNombre.text = nombre[indexPath.row]
        cell.lblMensaje.text = mensajes[indexPath.row]
        cell.imgContacto.image = UIImage(named:imagen[indexPath.row])
        
        return cell
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "politico" {
            
             if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let toViewController = segue.destination as? TextRequestViewController
                toViewController?.strNombre = nombre[indexPath.row]
                toViewController?.strImagen = imagen[indexPath.row]
                
                
            }
            
        }
        
        
    }
    

}
