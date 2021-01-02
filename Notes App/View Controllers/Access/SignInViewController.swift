//
//  SignInViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/18/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    private var userEntityController: UserEntityController!
    var indexUser: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func initializeController(){
        initializeUser()
        navigation()
    }
    
    private func navigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if check(){
            login()
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        clear()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SignInViewController{
    
    private func initializeUser(){
        userEntityController = UserEntityController()
    }
    
    private func check() -> Bool{
        if !usernameText.text!.isEmpty &&
            !passwordText.text!.isEmpty{
            return true
        }
        showAlert(title: "LanguageError", message: "LanguageEnterInfo", style: .destructive)
        return false
    }
    
    private func clear(){
        usernameText.text = ""
        passwordText.text = ""
    }
    
    private func login(){
        let loginRequest = userEntityController.login(userName: usernameText.text!.lowercased(), password: passwordText.text!)
        if loginRequest.isLoggedIn {
            if let _user = loginRequest.user{
                UserData.setData(user: _user)
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
                navigationController?.present(vc, animated: true, completion: nil)
                clear()
            }
        }else{
            showAlert(title: "LanguageError", message: "LanguageLoginFailed", style: .destructive)
        }
    }
    
}

