//
//  MyViewController.swift
//  DataCustom
//
//  Created by MacStudent on 2020-01-16.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class MyViewController: UIViewController,UISearchBarDelegate,DefaultChangeControllerDelegate {
    
    func detailController(_ controller: MyDetailViewController, didFinishAdding person: People, name: String, age: Int, tution: Double, startDate: Date , save: Bool) {
        
    
        
        if(save){ //5th step
            self.insertRecord(name:  name, age: age, tution: tution, startDate: startDate)
        }else{
            self.updateRecord(person: person, name:  name, age: age, tution: tution, startDate: startDate)
        }
        self.fetchAndUpdateTable()
        navigationController?.popViewController(animated:true)
    }
    
    

    
    
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet weak var serachBar: UISearchBar!
    
    var perArray = [People]()
    
    var filterArray = [People]()
    
    @IBAction func addNewData(_ sender: Any) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!

    
    func fetchAndUpdateTable(){//7th step
        perArray = fetchRecords()
        filterArray = perArray
        tableView.reloadData()
    }
    
    override func viewDidLoad() { //1st step
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        serachBar.delegate = self
        filterArray = perArray
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAndUpdateTable()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { //2 step

        filterArray = searchText.isEmpty ? perArray : perArray.filter({ (personString: People) -> Bool in

            return personString.name?.range(of: searchText, options:  .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "detailSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let destination = segue.destination as! MyDetailViewController
                destination.delegateDF = self
                
                destination.itemToEdit = filterArray[indexPath.row].name
                destination.itemToEditAge = String(filterArray[indexPath.row].age)
                destination.itemToEditTution = String(filterArray[indexPath.row].tution)
                destination.save = false
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .none
                
                destination.itemToEditDate = dateFormatter.string(from:filterArray[indexPath.row].startDate!)
                destination.person = filterArray[indexPath.row]
                
            }
        }
        if segue.identifier == "addSegue"{//3rd step
            let destination = segue.destination as! MyDetailViewController
            destination.delegateDF = self
            destination.save = true
        }
    }
    
    func insertRecord(name:String, age:Int, tution:Double, startDate:Date){ //6th step
             let person = People(context: managedContext)
             person.name = name
             person.age = Int32(age)
                  person.tution =   tution
                  person.startDate = startDate
        try! managedContext.save()
         }
         
    
    
         func fetchRecords() -> [People]{ //8th step
         var arrPerson = [People]()
         let fetchRequest = NSFetchRequest<People>(entityName: "People")
         
             do{
                 arrPerson = try managedContext.fetch(fetchRequest)
             }catch{
                 print(error)
             }
             return arrPerson
         }

    
    
         func deleteRecord( person : People){
            managedContext.delete(person)
          try! managedContext.save()
         }
         
    
    
         func updateRecord(person : People, name: String, age:Int, tution:Double, startDate:Date){//6th step
         person.name = name
             person.age = Int32(age)
              person.tution =   tution
              person.startDate = startDate
            try! managedContext.save()
         }
}

extension MyViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyCustomCell
        let person = filterArray[indexPath.row]
        
        cell?.nameTxt?.text = person.name!
        cell?.ageTxt?.text = String(person.age)
        cell?.tutionTxt?.text = String(person.tution)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        cell?.startDateTxt?.text = dateFormatter.string(from:person.startDate!)
        
                
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let person = perArray[indexPath.row]
            deleteRecord(person: person)
            fetchAndUpdateTable()
        }
    }
  
  

}
