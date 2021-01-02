//
//  NoteEntityController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 9/3/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NoteEntityController{
    
    public var context: NSManagedObjectContext!
    
    init(){
        initializerContext()
    }
    
    private func initializerContext(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
    }
    
    //CRUD
    public func create(note: Note) -> Bool{
        do{
            note.id = UUID()
            note.status = false
            context.insert(note)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }

    public func read() -> [Note]{
        do{
            let fetchRequset: NSFetchRequest = Note.fetchRequest()
            return try context.fetch(fetchRequset)
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    public func update(noteUpdate: Note) -> Bool{
        do{
            let fetchRequset: NSFetchRequest = Note.fetchRequest()
            fetchRequset.predicate = NSPredicate.init(format: "id = %@", noteUpdate.id! as CVarArg)
            
            let notes = try context.fetch(fetchRequset)
            if let note = notes.first{
                note.setValue(noteUpdate.titleNote, forKey: "titleNote")
                note.setValue(noteUpdate.descriptionNote, forKey: "descriptionNote")
                note.setValue(noteUpdate.status, forKey: "status")
                return true
            }
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    public func delete(note: Note) -> Bool{
        do{
            context.delete(note)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
}
