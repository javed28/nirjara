//
//  UserDefaults+SessionData.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/24/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
extension UserDefaults{
    
    enum UserDefaultsKeys : String {
        case isLoggedIn
        case userID
        case introLoggedIn
        case firstName
        case gender
        case email_id
        case language
        case member_type
        case memberName
        case adhithana
        case MobileNumber
        case lastAddress
       
    }
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    func getLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setIntroLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.introLoggedIn.rawValue)
        //synchronize()
    }
    
    func getIntroLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.introLoggedIn.rawValue)
    }
    
    //MARK: Save User Data
//    func setUserID(value: Int){
//        set(value, forKey: UserDefaultsKeys.userID.rawValue)
//        //synchronize()
//    }
//
//    //MARK: Retrieve User Data
//    func getUserID() -> Int{
//        return integer(forKey: UserDefaultsKeys.userID.rawValue)
//    }

    func setUserID(value: String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserID() -> String{
        return string(forKey: UserDefaultsKeys.userID.rawValue)!
    }
    func setMobileNumber(value: String){
        set(value, forKey: UserDefaultsKeys.MobileNumber.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getMobileNumber() -> String{
        return string(forKey: UserDefaultsKeys.MobileNumber.rawValue)!
    }
    
    
    
    func setFirstName(value: String){
        set(value, forKey: UserDefaultsKeys.firstName.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getFirstName() -> String{
        return string(forKey: UserDefaultsKeys.firstName.rawValue)!
    }
    
    
    
    func setLanguage(value: String){
        set(value, forKey: UserDefaultsKeys.language.rawValue)
        //synchronize()
    }
    
 
    func getLanguage() -> String{
        return string(forKey: UserDefaultsKeys.language.rawValue)!
    }
    
    func setMemberType(value: String){
        set(value, forKey: UserDefaultsKeys.member_type.rawValue)
        //synchronize()
    }
    
   
    func getMemberType() -> String{
        return string(forKey: UserDefaultsKeys.member_type.rawValue)!
    }
    
    func setMemberName(value: String){
        set(value, forKey: UserDefaultsKeys.memberName.rawValue)
        //synchronize()
    }
    
    func getMemberName() -> String{
        return string(forKey: UserDefaultsKeys.memberName.rawValue)!
    }
    func setAdhithana(value: String){
        set(value, forKey: UserDefaultsKeys.adhithana.rawValue)
        //synchronize()
    }
    
    func getAdhithana() -> String{
        return string(forKey: UserDefaultsKeys.adhithana.rawValue)!
    }
    func setLastAddress(value: String){
        set(value, forKey: UserDefaultsKeys.lastAddress.rawValue)
        //synchronize()
    }
    
    func getLastAddress() -> String{
        return string(forKey: UserDefaultsKeys.lastAddress.rawValue)!
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
}

