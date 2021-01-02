//
//  NewCategoryViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var typeViewLabel: UILabel!
    
    @IBOutlet weak var titleCategoryText: UITextField!
    @IBOutlet weak var descriptionCategoryTxet: UITextField!
    
    private var categoryEntityController: CategoryEntityController!
    var user: User?
    var category: Category?
    var index: Int?
    
    var isUpdate: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        // Do any additional setup after loading the view.
    }
    
    private func initializeView(){
        initializeCategory()
        if isUpdate!{
            titles(typeView: "LanguageUpdateCategory")
            updateView()
        }else{
            titles(typeView: "LanguageNewCategory")
        }
    }
    
    private func titles(typeView: String){
        titleViewLabel.text = NSLocalizedString("LanguageCategory", comment: "")
        typeViewLabel.text = NSLocalizedString(typeView, comment: "")
        
    }
    

    @IBAction func saveAction(_ sender: Any) {
        if isUpdate!{
            let isUpdated = update()
            isUpdated ? print(NSLocalizedString("LanguageDoneUpdate", comment: "")) : print(NSLocalizedString("LanguageFailedUpdate", comment: ""))
        }else{
            let isCreated = create()
            isCreated ?  print(NSLocalizedString("LanguageDoneCreate", comment: "")) : print(NSLocalizedString("LanguageFailedCreate", comment: "")) 
        }
    }
}

extension NewCategoryViewController{
    
    private func initializeCategory(){
        categoryEntityController = CategoryEntityController()
    }
    
    private func check() -> Bool{
        if !titleCategoryText.text!.isEmpty &&
            !descriptionCategoryTxet.text!.isEmpty{
            return true
        }
        return false
    }
    
    private func getData(){
        if !isUpdate!{
            category = Category(context: categoryEntityController.context)
            category?.user = user
        }
        if let _category = category{
            _category.titleCategory = titleCategoryText.text
            _category.descriptionCategory = descriptionCategoryTxet.text
        }
    }
    
    private func clear(){
        titleCategoryText.text = ""
        descriptionCategoryTxet.text = ""
    }
    
    private func create() -> Bool{
        if check(){
            getData()
            if let _category = category{
                let isCreated: Bool = categoryEntityController.create(category: _category)
                if isCreated{
                    clear()
                    return true
                }
            }
        }
        return false
    }

}

extension NewCategoryViewController{
    
    private func updateView(){
        titleCategoryText.text = category?.titleCategory ?? ""
        descriptionCategoryTxet.text = category?.descriptionCategory ?? ""
    }
    
    private func update() -> Bool{
        if check(){
            getData()
            let isUpdate: Bool = categoryEntityController.update(categoryUpdate: category!)
            if isUpdate{
                return true
            }
        }
        return false
    }
}
