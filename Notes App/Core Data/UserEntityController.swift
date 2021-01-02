//
//  UserEntityController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/25/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UserEntityController {
    
    public var context: NSManagedObjectContext!
    
    init() {
        initContext()
    }
    
    private func initContext(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }
    
    //CRUD
    public func create(user: User) -> Bool{
        do{
            user.id = UUID()
            context.insert(user)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func read() -> [User]{
        do{
            let fetchRequest: NSFetchRequest = User.fetchRequest()
            return try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    public func checkExistance(email: String, firstName: String)->Bool{
        do{
            let fetchRequest: NSFetchRequest = User.fetchRequest()
            let emailPredicate: NSPredicate = NSPredicate.init(format: "email = %@", email)
            let firstNamePredicate: NSPredicate = NSPredicate.init(format: "firstName = %@", firstName)
            fetchRequest.predicate = NSCompoundPredicate.init(orPredicateWithSubpredicates: [firstNamePredicate, emailPredicate])
            let users = try context.fetch(fetchRequest)
            return users.count > 0
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func login(userName: String, password: String) -> (user: User?, isLoggedIn: Bool ){
        do{
            let fetchRequest: NSFetchRequest = User.fetchRequest()
            //fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate.init(format: "firstName = %@", userName)
            
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty{
                let user = users.first
                let userPassword = user?.password ?? ""
                return userPassword.elementsEqual(password) ? (user, true) : (nil, false)
            }
        }catch let error as NSError {
            print(error)
        }
        return  (nil, false)
    }
    
    public func update(userUpdate:User) -> Bool{
       // let uuid: UUID = UUID(uuidString: userUpdate.id)!
        do{
            let fetchRequest: NSFetchRequest = User.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "id = %@", userUpdate.id! as CVarArg)
            
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty{
                if let user = users.first{
                    print("M2")
                    user.setValue(userUpdate.firstName , forKey: "firstName")
                    user.setValue(userUpdate.lastName , forKey: "lastName")
                    user.setValue(userUpdate.email , forKey: "email")
                    user.setValue(userUpdate.phone , forKey: "phone")
                    user.setValue(userUpdate.password, forKey: "password")
                    try context.save()
                    return true
                }
            }
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func getUser(id: String)->(status: Bool, user: User?){
        let uuid: UUID = UUID(uuidString: id)!
        do{
            let fetchRequest: NSFetchRequest = User.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "id = %@", uuid as CVarArg)
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty{
                if let user = users.first{
                    return (true, user)
                }
            }
        }catch let error as NSError{
            print(error)
        }
        return (false, nil)
    }
}
