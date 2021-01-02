//
//  UserData.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/26/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation

class UserData {
    
    private static let KeyID: String = "ID"
    private static let KeyFisrtName: String = "FISRTNAME"
    private static let KeyLastName: String = "LASTNAME"
    private static let KeyEmail: String = "EMAIL"
    private static let KeyPhone: String = "PHONE"
    private static let KeyPassword: String = "PASSWORD"
    
    public static func setData(user: User){
        UserDefaults.standard.set(user.id?.uuidString, forKey: KeyID)
        UserDefaults.standard.set(user.firstName, forKey: KeyFisrtName)
        UserDefaults.standard.set(user.lastName, forKey: KeyLastName)
        UserDefaults.standard.set(user.email, forKey: KeyEmail)
        UserDefaults.standard.set(user.phone, forKey: KeyPhone)
        UserDefaults.standard.set(user.password, forKey: KeyPassword)
    }
    
    /*
    public static func clearUserDefault(){
        UserDefaults.standard.removeObject(forKey: KeyFisrtName)
        UserDefaults.standard.removeObject(forKey: KeyLastName)
        UserDefaults.standard.removeObject(forKey: KeyEmail)
        UserDefaults.standard.removeObject(forKey: KeyPhone)
        UserDefaults.standard.removeObject(forKey: KeyPassword)
    }
    */
    public static func getData() -> UserInfo{
        let id = UserDefaults.standard.string(forKey: KeyID) ?? ""
        let firstName = UserDefaults.standard.string(forKey: KeyFisrtName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: KeyLastName) ?? ""
        let email = UserDefaults.standard.string(forKey: KeyEmail) ?? ""
        let phone = UserDefaults.standard.string(forKey: KeyPhone) ?? ""
        let password = UserDefaults.standard.string(forKey: KeyPassword) ?? ""
        return UserInfo(id: id, firstname: firstName, lastname: lastName, email: email, phone: phone, password: password)
    }
    
    public static func getUserId() -> String{
        return UserDefaults.standard.string(forKey: KeyID) ?? ""
    }
}
