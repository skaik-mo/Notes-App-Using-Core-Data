//
//  ProfileViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/22/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var characterUsernameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var countCategoryLabel: UILabel!
    @IBOutlet weak var countDoneNotesLabel: UILabel!
    @IBOutlet weak var countWittingNotesLabel: UILabel!

    private var userEntityController: UserEntityController!
    private var users: [User]?
    private var user: User?
    
    private var oldFirstName: String?
    private var password: String?
    
    private var categories: [Category] = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializerContrlloer()
        // Do any additional setup after loading the view.
    }
    
    private func initializerContrlloer(){
        userData()
        settingsUser()
        getData()
        initializeUser()
        countCategory()
    }
    
    private func countCategory(){
        countCategoryLabel.text = String(describing: user?.categories?.count ?? 0)
        categories = user!.categories?.allObjects as! [Category]
        var countAllNote: Int = 0
        var countNotesStatusTrue: Int = 0
        var countNotesStatusfalse: Int = 0
        if categories.count > 0 {
            for index in 0...categories.count-1{
                let notes = categories[index].notes?.allObjects as! [Note]
                if !notes.isEmpty{
                    countAllNote += notes.count
                    print("index -> \(index)  count \(notes.count-1)")
                    for indexNote in 0...notes.count-1{
                        if notes[indexNote].status{
                            countNotesStatusTrue += 1
                        }else{
                            countNotesStatusfalse += 1
                        }
                    }
                }
            }
        }
        countDoneNotesLabel.text = String(describing: countNotesStatusTrue)
        countWittingNotesLabel.text = String(describing: countNotesStatusfalse)
    }
    
    private func userData(){
        let loggedInUser = UserEntityController().getUser(id: UserData.getUserId())
        if loggedInUser.status, let _user = loggedInUser.user{
            user = _user
            print("USER ID:",user?.id ?? "")
        }else{
            print("FAILED")
        }
    }
    
    private func settingsUser(){
        if let _user = user{
            characterUsernameLabel.text = _user.firstName!.prefix(1).uppercased()
            oldFirstName = _user.firstName ?? ""
            let fullName: String = "\(_user.firstName ?? "") \(_user.lastName ?? "")"
            userNameLabel.text = fullName
            emailLabel.text = _user.email ?? ""
        }
        
    }
    
    private func getData(){
        if let _user = user{
            firstNameText.text = _user.firstName ?? ""
            lastNameText.text = _user.lastName ?? ""
            phoneText.text = _user.phone ?? ""
            emailText.text = _user.email ?? ""
            password = _user.password ?? ""
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        Update()
    }
}

extension ProfileViewController{
    
    private func initializeUser(){
        userEntityController = UserEntityController()
        users = userEntityController.read()
    }
    
    private func check() -> Bool{
        if !firstNameText.text!.isEmpty &&
            !lastNameText.text!.isEmpty &&
            !phoneText.text!.isEmpty &&
            !emailText.text!.isEmpty{
            return true
        }
        showAlert(title: "LanguageError", message: "LanguageEnterInfo", style: .destructive)
        return false
    }
    
    private func searchEmail(size: Int) -> Bool{
        if let _users = users{
            for index in 0...size-1{
                let user = _users[index]
                if user.email!.lowercased() == emailText.text!.lowercased() {
                    // if found email then No Update
                    // message email already exists
                    return false
                }
            }
        }
        return true
    }

    private func searchFirstName(size: Int) -> Bool{
        if let _users = users{
            for index in 0...size-1{
                let user = _users[index]
                if user.firstName!.lowercased() == firstNameText.text!.lowercased() {
                    // if found fisrt Name then No Updata
                    // message first Name already exists
                    return false
                }
            }
        }
        // if doesn't exists then Update
        return true
    }
    
    private func checkFirstName() -> Bool{
        if oldFirstName!.lowercased() == firstNameText.text!.lowercased(){
            // if old first Name equal new first Name then Update
            return true
        }
        // if old first Name Not equal new first Name then No Update
        return false
    }

    private func checkEmail() -> Bool{
        if emailLabel.text!.lowercased() == emailText.text!.lowercased(){
            // if old email equal new email then Update
            return true
        }
        // if old email not equal new email then No Update
        return false
    }

    private func sorted(size: Int) -> Bool{
        if size == 0  { return false }

        let FirstName: Bool = searchFirstName(size: size)
        let Email: Bool = searchEmail(size: size)

        if FirstName && Email{
            // if first Name and Email doesn't exists then Update
            print("done1")
            return true

        }else if FirstName && !Email{
            // if first Name doesn't exists and Email exists then check email
            print("done2 \(checkEmail())")
            return checkEmail()

        }else if !FirstName && Email{
            // if first Name exists and Email doesn't exists then check first Name
            print("done3 \(checkFirstName())")
            return checkFirstName()

        }else{
            // if first Name and Email exists then check first Name and Email
            print("done4***")
            if checkFirstName() && checkEmail(){
                //if old first Name equal new first Name and old Email equal new Email then Update
                print("done4***")
                return true

            }else if checkFirstName() && !checkEmail(){
                //if old first Name equal new first Name and old Email Not equal new Email then Update
                //message Email already exists
                showAlert(title: "LanguageError", message: "LanguageEmailAlreadyExists", style: .destructive)
                return false
            }else if !checkFirstName() && checkEmail(){
                //if old first Name Not equal new first Name and old Email equal new Email then Update
                //message first Name already exists
                showAlert(title: "LanguageError", message: "LanguageFirstNameAlreadyExists", style: .destructive)
                return false
            }else{
                //if old first Name Not equal new first Name and old Email Not equal new Email then Update
                //message first Name and Email already exists
                showAlert(title: "LanguageError", message: "LanguageFirstName&EmailAlreadyExists", style: .destructive)
                return false
            }
        }
    }
    
    private func getUser(){
        if let _user = user{
            _user.firstName = firstNameText.text
            _user.lastName = lastNameText.text
            _user.phone = phoneText.text
            _user.email = emailText.text
            _user.password = password
        }
    }
    
    private func Update(){
        if sorted(size: users?.count ?? 0) && check(){
            getUser()
            if let _user = user{
                let isUpdated: Bool = userEntityController.update(userUpdate: _user)
                print(isUpdated)
                if isUpdated{
                    UserData.setData(user: _user)
                    settingsUser()
                    showAlert(title: "LanguageSuccessful", message: "LanguageDoneUpdate", style: .default)
                }
            }
        }
    }
    
}
