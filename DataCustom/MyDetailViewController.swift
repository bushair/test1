//
//  MyDetailViewController.swift
//  DataCustom
//
//  Created by MacStudent on 2020-01-16.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit


protocol DefaultChangeControllerDelegate {
    
    
    func detailController(_ controller: MyDetailViewController, didFinishAdding person: People, name: String, age:Int, tution:Double, startDate: Date, save: Bool)
}

class MyDetailViewController: UIViewController {
    
    var itemToEdit: String?
    var save = true
    var itemToEditAge: String?
    var itemToEditTution: String?
    var itemToEditDate: String?
    var person = People()
    var datePicker = UIDatePicker()
    
    @IBAction func addRecord(_ sender: Any) {//4th strp
        if(nameTxt.text == "" || ageTxt.text == "" || tutionTxt.text == "" || dateTxt.text == ""){
            
            let alert = UIAlertController(title: "Field is Empty", message: "Please Enter Info", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            
            //dateFormatter.date(from: <#T##String#>)
            
            delegateDF?.detailController(self, didFinishAdding: person, name: nameTxt.text!, age: Int(ageTxt.text!)!, tution: Double(tutionTxt.text!)!,startDate: dateFormatter.date(from: dateTxt.text!)!, save: save)
        }
    }
    @IBOutlet weak var barItemTxt: UIBarButtonItem!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var tutionTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    
    var delegateDF: DefaultChangeControllerDelegate?
    
    
    
    @IBAction func ChangedPress(_ sender: Any) {
        if(nameTxt.text == ""){
            
            let alert = UIAlertController(title: "Field is Empty", message: "Please Enter Amount", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }else{
            
            // delegateDF?.detailController(self, didFinishAdding: nameTxt.text!)
        }
        
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTxt.inputAccessoryView = toolbar
        dateTxt.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        //          let formatter = DateFormatter()
        //          formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        dateTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(save){
            barItemTxt.title = "Save"
            
        }
        else{
            barItemTxt.title = "Update"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        if let itemToEdit = itemToEdit {
            title = "Edit Item"
            nameTxt.text = itemToEdit
            ageTxt.text = itemToEditAge
            tutionTxt.text = itemToEditTution
            dateTxt.text = itemToEditDate
           
        }
    }
    
    
}

