//
//  SettingTableViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/22/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                showLanguageAlert()
            }else if indexPath.row == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                navigationController?.pushViewController(vc, animated: true)
            
            }else if indexPath.row == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutAppViewController") as! AboutAppViewController
                navigationController?.pushViewController(vc, animated: true)

            }else if indexPath.row == 3 {
                //let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                //navigationController?.pushViewController(vc, animated: true)
            
            }else if indexPath.row == 4 {
                SceneDelegate().navigateRegardingToUserStatus(status: false)
            }
        }
    }

    private func showLanguageAlert(){
        let alertController = UIAlertController(title: NSLocalizedString("LanguageSheetTitle", comment: ""), message: NSLocalizedString("LanguageSheetMessage", comment: ""), preferredStyle: .actionSheet)
        let alertActionAR = UIAlertAction(title: "العربية", style: .default) { (action) in
            self.changeLanguage(languageCode: "ar")
        }
        let alertActionEN = UIAlertAction(title: "English", style: .default) { (action) in
            self.changeLanguage(languageCode: "en")
        }
        alertController.addAction(alertActionAR)
        alertController.addAction(alertActionEN)
        present(alertController, animated: true, completion: nil)
    }
    
    private func changeLanguage(languageCode: String){
        if L102Language.currentAppleLanguage() != languageCode{
            L102Language.changeLanguage(view: self, newLang: languageCode, rootViewController: "HomeNC")
        }else{
            print("Language already selected !!")
        }
    }

}


