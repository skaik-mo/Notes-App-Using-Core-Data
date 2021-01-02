//
//  SettingsViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/22/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var characterUsernameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    //var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsNavigation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsUser()
    }
    
    private func settingsNavigation(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Quicksand-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor(named: "474559")!]
    }

    private func settingsUser(){
        let userInfo: UserInfo = UserData.getData()
        characterUsernameLabel.text = userInfo.firstname.prefix(1).uppercased()
        let fullName: String = "\(userInfo.firstname) \(userInfo.lastname)"
        userNameLabel.text = fullName
        emailLabel.text = userInfo.email
    }
    
}
