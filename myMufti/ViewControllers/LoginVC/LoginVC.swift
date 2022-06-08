//
//  ViewController.swift
//  myMufti
//
//  Created by Qazi on 10/12/2021.
//

import UIKit
import Alamofire
import SwiftSpinner
import GoogleSignIn

class LoginVC: UIViewController {
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var gSignInBtn: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.layer.cornerRadius = 8
        gSignInBtn.layer.cornerRadius = 8
        backMainView.layer.cornerRadius = 20
        
        let loginDetails = UserDefaults.standard.value(forKey: UserDefaultsKeys.email.rawValue)
        if loginDetails != nil {
            print("UserDefaults save Data")
            emailTF.text = UserDefaults.standard.value(forKey: UserDefaultsKeys.email.rawValue) as? String
            passwordTF.text = UserDefaults.standard.value(forKey: UserDefaultsKeys.password.rawValue) as? String
        } else {
            asqa_Alert(message: "UserDefaults are Not saved")
        }
        
        
    }
    //MARK:- ForgotPassword Btn Action
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordEmailVC") as! ForgotPasswordEmailVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    // MARK:- Login Buttons Validation //MARK:- TextFeilds Validation
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if isTextFeildsAreEmpty() {
            // show alert
            asqa_Alert(message: "Please fill all the fields")
        }else{
            let isEmailValid = isValidEmailAddress(emailAddressString: emailTF.text!)
            if isEmailValid {
                if passwordTF.text!.count < 6 {
                    asqa_Alert(message: "password legth is must be 6 Character")
                }else {
                    // call network api
                    callLoginAPI()
                }
                // if emailIs Valid then Check the length of Password
            }else {
                asqa_Alert(message: "email address is not Valid")
            }
        }
    }
    //  MARK:- Google Sign In Button Action
    @IBAction func googleBtnDidtap(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
          guard error == nil else { return }
          // If sign in succeeded, display the app's main content View.
            let name = user?.profile?.name
            let email = user?.profile?.email
            let token = user?.authentication.accessToken
            callGoogleWithLoginAPI(name: name!, email: email!, social_Token: token!)
            print(user as Any)
        }
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFeildsAreEmpty() -> Bool{
        // this func just check either textfields are empty or not
        if (passwordTF.text!.isEmpty  || emailTF.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    // MARK:- Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "My Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //MARK:- Function of  Email Validation and Go on Next Home Screen 
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    func movetoHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC  = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    func movetoProfileScreen() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let tabBarVC  = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    //    MARK:- Api Function Call
    func callLoginAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/login"
        let  parameter = [
            "email": emailTF.text!,
            "password": passwordTF.text!
        ]
        SwiftSpinner.show("Loading...")
       
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default).response { [self] response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        print(String(data: data, encoding: .utf8) as Any)
                        let decoder = JSONDecoder()
                        do {
                            let userModel = try decoder.decode(UserModel.self, from: data)
                            if userModel.status == true {
                                // Save These values UserDefaults
                                // UserId
                                // UserEmail
                                // UserPassword
                                UserDefaults.standard.set(self.emailTF.text!, forKey: UserDefaultsKeys.email.rawValue)
                                UserDefaults.standard.set(self.passwordTF.text!, forKey:UserDefaultsKeys.password.rawValue)
                                UserDefaults.standard.set(userModel.data?.name, forKey: UserDefaultsKeys.userName.rawValue)
                                UserDefaults.standard.set(userModel.data?.id, forKey: UserDefaultsKeys.user_id.rawValue)
                                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isUserLogin.rawValue)
                                let imageURL = userModel.data?.image?.replacingOccurrences(of: "https", with: "http")
                                UserDefaults.standard.setValue(imageURL, forKey: UserDefaultsKeys.profile_Image.rawValue)
                                // move to next screen home
                                movetoHomeScreen()
                            } else {
                                // show error message
                                self.asqa_Alert(message: userModel.message)
                            }
                            
                        }
                        catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
//Googole With login Api
extension LoginVC {
    func callGoogleWithLoginAPI(name: String, email: String , social_Token: String) {
        let baseURL = "http://mymufti.megaxtudio.com/Users/signUpSocial"
        let  parameter = [
            "email": email,
            "name": name,
            "user_type": "user",
            "social_key": "google",
            "social_token": social_Token
        ]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default).response { [self] response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        print(String(data: data, encoding: .utf8) as Any)
                        let decoder = JSONDecoder()
                        do {
                            let googleModel = try decoder.decode(GoogleWithLoginModel.self, from: data)
                            if googleModel.status == true {
                                // move to next screen home
                                movetoProfileScreen()
                            } else {
                                // show error message
                                self.asqa_Alert(message: googleModel.message)
                            }
                        }
                        catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
