//
//  CategoryEntityController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/26/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoryEntityController {
    
    public var context: NSManagedObjectContext!
    
    init() {
        initializeContext()
    }
    
    private func initializeContext(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        context = appDelegate.persistentContainer.viewContext
    }
    //CRUD
    public func create(category: Category) -> Bool{
        do{
            category.id = UUID()
            print("ID:",category.id ?? "")
            context.insert(category)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func update(categoryUpdate: Category) -> Bool{
        let uuidString = categoryUpdate.id?.uuidString ?? ""
        let uuid: UUID = UUID(uuidString: uuidString)!
        
        do{
            let fetchRequset: NSFetchRequest = Category.fetchRequest()
            fetchRequset.predicate = NSPredicate.init(format: "id = %@", uuid as CVarArg)
            let categories = try context.fetch(fetchRequset)
            
            if let category = categories.first{
                category.setValue(categoryUpdate.titleCategory, forKey: "titleCategory")
                category.setValue(categoryUpdate.descriptionCategory, forKey: "descriptionCategory")
                try context.save()
                return true
            }
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func delete(category: Category) -> Bool{
        do{
            context.delete(category)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
}
