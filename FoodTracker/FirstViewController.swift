//
//  FirstViewController.swift
//  FoodTracker
//
//  Created by Joshua on 4/2/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var ListingTableView: UITableView!
    
    @IBOutlet weak var AddButton: UIButton!
    
    var tableData = [["Ketchup", "4/23/2017"], ["Mustard", "6/2/2018"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //AddButton.layer.borderWidth =
        //AddButton.layer.
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Message1", message: "Message2", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let fNameField = alertController.textFields![0] as UITextField
            let lNameField = alertController.textFields![1] as UITextField
            
            self.tableData.append([fNameField.text!, lNameField.text!])
            print(self.tableData)
            self.ListingTableView.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            alert -> Void in
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in textField.placeholder = "Food"
            textField.textAlignment = .center
        })
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in textField.placeholder = "Expiration Date"
            textField.textAlignment = .center
        })
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodDisplayCell
        cell.NameLabel?.text = tableData[indexPath.item][0]
        cell.ExpDateLabel?.text = tableData[indexPath.item][1]
        return cell
    }
}

extension FirstViewController: UITableViewDataSource{
    
}

class FoodDisplayCell: UITableViewCell{
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var ExpDateLabel: UILabel!
    
    
}
