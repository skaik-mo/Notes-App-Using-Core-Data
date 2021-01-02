//
//  NotesViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet var noteTableView: UITableView!

    private var noteEntityController: NoteEntityController!
    private var notes: [Note] = [Note]()
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializerView()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _category = category{
            notes = _category.notes?.allObjects as! [Note]
        }
        noteTableView.reloadData()
        print("count",notes.count)
    }
    
    private func initializerView(){
        navigation()
        initializeTableView()
        initailzerNote()
    }
    
    private func navigation(){
        navigationItem.title = category?.titleCategory
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    @IBAction func newNoteAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteViewController") as! NewNoteViewController
        vc.isUpdate = false
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    
    
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func initailzerNote(){
        noteEntityController = NoteEntityController()
    }
    
    func initializeTableView(){
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.checkButtonDelegate = self
        cell.indexPath = indexPath
        cell.setData(note: notes[indexPath.row])
        cell.isStatusButton(isStatus: notes[indexPath.row].status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteViewController") as! NewNoteViewController
        vc.isUpdate = true
        vc.category = category
        vc.note = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let isDeleted = noteEntityController.delete(note: notes[indexPath.row])
            if isDeleted{
                notes.remove(at: indexPath.row)
                noteTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
}


extension NotesViewController: CheckButton{
    
    func status(indexPath: IndexPath) -> Bool {
        let isStatus = notes[indexPath.row].status
        if isStatus{
            notes[indexPath.row].status = false
            let isUpdated = noteEntityController.update(noteUpdate: notes[indexPath.row])
            print(isUpdated)
            return false
        }
        notes[indexPath.row].status = true
        let _ = noteEntityController.update(noteUpdate: notes[indexPath.row])
        return true
    }

    
}


