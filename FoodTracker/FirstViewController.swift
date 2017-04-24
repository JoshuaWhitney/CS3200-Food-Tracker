//
//  FirstViewController.swift
//  FoodTracker
//
//  Created by Joshua on 4/2/17.
//  Copyright © 2017 Joshua. All rights reserved.
//
//  Core Data functionality taken from:
//  https://www.raywenderlich.com/145809/getting-started-core-data-tutorial

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var ListingTableView: UITableView!
    @IBOutlet weak var AddButton: UIButton!
    
    var tableData: [NSManagedObject] = []
    
    var formatter = DateFormatter()
    var activeSort = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adjust the alerts bounds
        //AddButton.layer.borderWidth =
        //AddButton.layer.
        // Do any additional setup after loading the view, typically from a nib.
        formatter.dateFormat = "MM/dd/yyyy"
        self.ListingTableView.allowsMultipleSelectionDuringEditing = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FoodItem")
        
        //3
        do {
            tableData = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = tableData[indexPath.row].value(forKey: "name") as! String
            deleteRecordWithName(name: item)
            tableData.remove(at: indexPath.row)
            self.ListingTableView.reloadData()
        }
    }
    
    
    @IBAction func AddButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Message1", message: "Message2", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let fNameField = alertController.textFields![0] as UITextField
            let brandField = alertController.textFields![1] as UITextField
            let dateField = alertController.textFields![2] as UITextField
            
            
            //self.tableData.append([fNameField.text!, lNameField.text!])
            self.save(name: fNameField.text!, brand: brandField.text!, expiration: self.formatter.date(from: dateField.text!)!)
            print(self.tableData)
            
            self.ListingTableView.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            alert -> Void in
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in textField.placeholder = "Food"
            textField.textAlignment = .center
        })
        
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in textField.placeholder = "Brand"
            textField.textAlignment = .center
        })
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in textField.placeholder = "Expiration Date (MM/DD/YYYY)"
            textField.textAlignment = .center
        })
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func SortByNameAction(_ sender: Any) {
        if (activeSort == 2){
            tableData.sort(by: {$0.value(forKey: "name") as! String > $1.value(forKey: "name") as! String})
            activeSort = 1
        }
        else {
            tableData.sort(by: {$1.value(forKey: "name") as! String > $0.value(forKey: "name") as! String})
            activeSort = 2
        }
        self.ListingTableView.reloadData()
    }
    
    @IBAction func SortByBrandAction(_ sender: Any) {
        if (activeSort == 4){
            tableData.sort(by: {$0.value(forKey: "brand") as! String > $1.value(forKey: "brand") as! String})
            activeSort = 3
        }
        else {
            tableData.sort(by: {$1.value(forKey: "brand") as! String > $0.value(forKey: "brand") as! String})
            activeSort = 4
        }
        self.ListingTableView.reloadData()
    }
    
    @IBAction func SortByDateAction(_ sender: Any) {
        if (activeSort == 6){
            tableData.sort(by: {$0.value(forKey: "expiration") as! Date > $1.value(forKey: "expiration") as! Date})
            activeSort = 5
        }
        else {
            tableData.sort(by: {$1.value(forKey: "expiration") as! Date > $0.value(forKey: "expiration") as! Date})
            activeSort = 6
        }
        self.ListingTableView.reloadData()
    }
    
    
    
    func deleteRecordWithName(name: String) -> Void {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [FoodItem]
        
        for object in resultData {
            if (object.value(forKey: "name") as? String == name){
                moc.delete(object)
            }
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    func save(name: String, brand: String, expiration: Date) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "FoodItem",
                                       in: managedContext)!
        
        let food = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        food.setValue(name, forKeyPath: "name")
        food.setValue(brand, forKeyPath: "brand")
        food.setValue(expiration, forKeyPath: "expiration")
        
        // 4
        do {
            try managedContext.save()
            tableData.append(food)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func notificationDebug(_ sender: Any) {
    }
}

extension FirstViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodDisplayCell
        let food = tableData[indexPath.row]
        cell.NameLabel?.text = food.value(forKey: "name") as? String
        cell.BrandLabel?.text = food.value(forKey: "brand") as? String
        //brandlabel.text = "brand"
        let printDate = formatter.string(from: food.value(forKey: "expiration") as! Date) 
        cell.ExpDateLabel?.text = printDate
        return cell
    }
    
}

class FoodDisplayCell: UITableViewCell{
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var BrandLabel: UILabel!
    
    @IBOutlet weak var ExpDateLabel: UILabel!
}

func sort(sortArray: Array<Any>, sortParameter: Int){
    if (sortParameter == 0){
        print("0 sort")
    }
}
