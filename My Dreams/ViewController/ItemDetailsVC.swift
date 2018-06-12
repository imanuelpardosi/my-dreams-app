//
//  ItemDetailsVC.swift
//  My Dreams
//
//  Created by Mobile Jakarta Team on 03/06/18.
//  Copyright © 2018 moonshadow. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        detailsField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        detailsField.text = "Details"
        detailsField.textColor = UIColor.lightGray
        detailsField.layer.borderWidth = 1
        detailsField.layer.borderColor = UIColor.gray.cgColor
        detailsField.layer.cornerRadius = 5
        
        //self.generateTestData()
        self.getStore()
        
        if itemToEdit != nil {
            self.loadItemData()
        }
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            itemImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    func generateTestData() {
        let store = Store(context: context)
        store.name = "Tokopedia"
        let store2 = Store(context: context)
        store2.name = "Bukalapak"
        let store3 = Store(context: context)
        store3.name = "Blibli"
        let store4 = Store(context: context)
        store4.name = "Alibaba"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        appDelegate.saveContext()
    }
    
    func getStore() {
        let fetchRequest: NSFetchRequest<Store>  = Store.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print(error)
        }
    }
    
    @IBAction func btnAddImageOnClick(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteOnClick(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            appDelegate.saveContext()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveOnClick(_ sender: Any) {
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = itemImg.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toImage = picture
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension ItemDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

extension ItemDetailsVC:  UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if detailsField.textColor == UIColor.lightGray {
            detailsField.text = nil
            detailsField.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailsField.text.isEmpty {
            detailsField.text = "Details"
            detailsField.textColor = UIColor.lightGray
        }
    }
    
}

extension ItemDetailsVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
