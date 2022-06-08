//
//  File.swift
//  MoToDo
//
//  Created by Rauf on 25/09/2021.

import Foundation
import UIKit

enum UserDefaultKeys: String {
    
case userID
case name
case email
case password
case image
case isSocialLogin
}

class CustomUserDefaults {
    /**
     */
   static let shared = CustomUserDefaults()
    
// MARK:- Logging In
    func isUserLogin() -> Bool {
        
        if UserDefaults.standard.value(forKey: UserDefaultKeys.userID.rawValue) == nil {
          print("not working")
            return false
        } else  {
            print("working")
            return true
        }
    }
    
// MARK:- Logging Out
    func isUserLogout() -> Bool {
        
        let domain = Bundle.main.bundleIdentifier!
        
            UserDefaults.standard.removePersistentDomain(forName: domain)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainNavBar")
            UIApplication.shared.windows.first?.rootViewController = vc
            
            print("logged out")
            return true
        
    }
    func goToHomeScreen(){
            guard let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NavBar") as? UINavigationController else {print("no homr nsv");return}
        
            UIView.animate(withDuration: 0.3) {
                    
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }

//    func saveLoginData(userLoginData: LoginModel) {
//    
//        UserDefaults.standard.setValue(userLoginData.data?.id, forKey: UserDefaultKeys.userID.rawValue)
//        UserDefaults.standard.setValue(userLoginData.data?.email, forKey: UserDefaultKeys.email.rawValue)
//        UserDefaults.standard.setValue(userLoginData.data?.password, forKey: UserDefaultKeys.password.rawValue)
//        UserDefaults.standard.setValue(userLoginData.data?.name, forKey: UserDefaultKeys.name.rawValue)
//        UserDefaults.standard.setValue(userLoginData.data?.image, forKey: UserDefaultKeys.image.rawValue)
//    }
    
    func isUserSignUp() -> Bool {
        /**
            this funcion is use to check either use is login or not
         - parameters:
                
         */
        if  UserDefaults.standard.value(forKey: UserDefaultKeys.userID.rawValue) == nil {
            print("it is not working")
            return false
            
        } else {
            print("it is working")
            return true
        }
    }
    
//    func saveSignUpData(userSignUpData: SignUpModel, isSocialLogin: Bool) {
//        
//        UserDefaults.standard.setValue(userSignUpData.data?.id, forKey: UserDefaultKeys.userID.rawValue)
//        UserDefaults.standard.setValue(userSignUpData.data?.email, forKey: UserDefaultKeys.email.rawValue)
//        UserDefaults.standard.setValue(userSignUpData.data?.password, forKey: UserDefaultKeys.password.rawValue)
//        UserDefaults.standard.setValue(userSignUpData.data?.name, forKey: UserDefaultKeys.name.rawValue)
//        UserDefaults.standard.setValue(userSignUpData.data?.image, forKey: UserDefaultKeys.image.rawValue)
//        UserDefaults.standard.setValue(isSocialLogin, forKey: UserDefaultKeys.isSocialLogin.rawValue)
//    }
 
}
