//
//  SignUpVC.swift
//  LoveNLead
//
//  Created by Taimoor on 11/11/21.
//

import UIKit
import SwiftSpinner
import FirebaseAuth

class SignUpVC: UIViewController {
    // @IBOutlet
    @IBOutlet weak var emailTxtfld: RoundedTxtFld!
    @IBOutlet weak var nameTxtfld: RoundedTxtFld!
    @IBOutlet weak var phoneTxtfld: RoundedTxtFld!
    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var passwordTxtFld: RoundedTxtFld!
    
    var firebaseID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAlreadyLogin()
    }
    
    //    MARK: Buttons Tapped
    @IBAction func signUpTapped(_ sender: Any) {
        
        callSignInAPI()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        navigateToControllers(name: "Main", identifier: "LoginVC")
    }
    
    func userAlreadyLogin() {
        
        if CustomUserDefaults.shared.isUserLogin() {
                
                navigateToControllers(name: "ProfileStoryboard", identifier: "SWRevealViewController")
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
// MARK: extenion for API
extension SignUpVC {
    
    func SignUpAPI(name: String, email: String, phoneNo: String, password: String, firebaseID: String) {
        
        SwiftSpinner.show("connecting...")
        
        let url = "Users/signup"
        
        let parameters = [
            
            "user_name": name,
            "email": email,
            "phone": phoneNo,
            "password": password,
            "fireBase_id": firebaseID
        ]
        
        ApiManager.URLResponse(url, method: .post, parameters: parameters, headers: nil) { (SignUpData) in
            SwiftSpinner.hide()
            
            let SignUpModelData = try? JSONDecoder().decode(SignUpModel.self, from: SignUpData)
            //            print(SignUpModelData ?? "data not found.")
            
            if SignUpModelData?.status == 1 {
                
                CustomUserDefaults.shared.saveSignUpData(userSignUpData: SignUpModelData!, isSocialLogin: false)
                let model = SignUpModelData?.data
                
                let chatUser = ChatAppUser(userName: model?.userName ?? "", firebaseID: model?.firebaseId ?? "", personalUserID: model?.userID ?? "", phoneNumber: model?.phone ?? "", status: "online", userEmail: model?.email ?? "")
                
                DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                    
                    if success {
                        //                            upload picture
                        
                    } else {
                        //                            failed to upload
                        print("failed to upload image on firebase")
                    }
                    
                })
                UserDefaults.standard.set(SignUpModelData?.data?.firebaseId, forKey: UserDefaultKeys.firebaseID.rawValue)
                self.navigateToControllers(name: "ProfileStoryboard", identifier: "SWRevealViewController")
        
            } else {
                SwiftSpinner.hide()
                AlertMessages.standard.showAlert(type: .error, title: SignUpModelData?.message ?? "login failed")
            }
            
        } withapiFiluer: { (error) in
            
            print(error)
        }
    }
}

extension SignUpVC {
    
    func callSignInAPI() {
        
        guard let email = emailTxtfld.text, !email.isEmpty, isValidEmail(email) == true else {
            return
        }
        guard let password = passwordTxtFld.text, !password.isEmpty, password.count >= 6 else {
            
            AlertMessages.standard.showAlert(type: .error, title: "Password must be 6 characters long")
            return
        }
        guard let name = nameTxtfld.text, !name.isEmpty else {
            return
        }
        guard let phoneNo = phoneTxtfld.text, !phoneNo.isEmpty else {
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                AlertMessages.standard.showAlert(type: .error, title: "Email already exist")
                print("Email already exist")
                return
            }
            
            self.firebaseID = authResult?.user.uid ?? ""
            
            self.uploadPictureOnStorageManager(myImage: UIImage(named: "profile")!, firebaseID: (authResult?.user.uid)!)
            
            self.SignUpAPI(name: name, email: email, phoneNo: phoneNo, password: password, firebaseID: (authResult?.user.uid)!)
        })
    }
}
