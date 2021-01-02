//
//  NewNoteViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
            
    private var noteEntityController: NoteEntityController!
    var note: Note?
    var category: Category?
    var isUpdate: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializerView()

    }
    
    private func initializerView(){
        initializerNote()
        if isUpdate!{
            titles(typeView: "LanguageUpdateNote")
            updateView()
        }else{
            titles(typeView: "LanguageNewNote")
        }
    }
    
    private func titles(typeView: String){
        titleLabel.text = NSLocalizedString("LanguageNote", comment: "")
        typeLabel.text = NSLocalizedString(typeView, comment: "")
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

extension NewNoteViewController{
    
    private func initializerNote(){
        noteEntityController = NoteEntityController()
    }
    
    private func check() ->Bool{
        if !titleText.text!.isEmpty &&
            !descriptionText.text!.isEmpty{
            return true
        }
        return false
    }

    private func getNote(){
        if !isUpdate!{
            note = Note(context: noteEntityController.context)
            note?.category = category
        }
        if let _note = note{
            _note.titleNote = titleText.text!
            _note.descriptionNote = descriptionText.text!
        }
    }
    
    private func clear(){
        titleText.text = ""
        descriptionText.text = ""
    }
    
    private func create() -> Bool{
        if check(){
            getNote()
            if let _note = note{
                let isCreated = noteEntityController.create(note: _note)
                if isCreated{
                    clear()
                    return true
                }
            }
        }
        return false
    }
    

    
}

extension NewNoteViewController{
 
    private func updateView(){
        titleText.text = note?.titleNote
        descriptionText.text = note?.descriptionNote
    }
    
    private func update() -> Bool{
        if check(){
            getNote()
            if let _note = note{
                return noteEntityController.update(noteUpdate: _note)
            }
        }
        return false
    }
    
}
