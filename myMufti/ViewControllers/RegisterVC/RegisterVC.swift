//
//  RegisterVC.swift
//  myMufti
//
//  Created by Qazi on 14/12/2021.
//

import UIKit
import Alamofire
import SwiftSpinner
import GoogleSignIn

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rePasswordTF: UITextField!
    @IBOutlet weak var signUpBTn: UIButton!
    @IBOutlet weak var googleSignInBtn: UIView!
    @IBOutlet weak var logInBtn: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        signUpBTn.layer.cornerRadius = 8
        backMainView.layer.cornerRadius = 20
        googleSignInBtn.layer.cornerRadius = 8
    }
    //MARK:- LoginBtn Back
    @IBAction func loginBackBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    // MARK:- SignUp Buttons Validation or TextFeilds, Email Or Password Validation
    @IBAction func signUpBtn(_ sender: Any) {
        if isTextFieldsAreEmpty() {
            // show alert
            asqa_Alert(message: "Please fill all the fields")
        } else {
            // If email valid or not
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailTF.text!)
            if isEmailAddressValid {
                if (passwordTF.text!.count < 6 || rePasswordTF.text!.count < 6 ) {
                    asqa_Alert(message: "password legth is must be 6 Character")
                } else {
                    if passwordTF.text != rePasswordTF.text {
                        asqa_Alert(message: "Password is Not Match")
                    }else {
                        // move to next screen
                        callApiSignUp()
                    }
                }
                // if emailIs Valid then Check the length of Password
            } else {
                asqa_Alert(message: "email address is not Valid")
            }
        }
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFieldsAreEmpty() -> Bool {
        
        if (emailTF.text!.isEmpty || passwordTF.text!.isEmpty || rePasswordTF.text!.isEmpty || nameTF.text!.isEmpty) {
            return true
        } else {
            // this will run once on textfiled have empty value
            return false
        }
    }
    // Function of Alert Validation
    func asqa_Alert(message: String) {
        
        let alertBlankInput = UIAlertController(title: "My Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    // Function of  Email Validation or Function of Next Screen
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
    //    SignUp Button click on Home screen
    func movetoHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    //    Google with Login Button Click on Profile Screen
    func movetoProfileScreen() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let tabBarVC  = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
//MARK:- Api function call
extension RegisterVC {
    func callApiSignUp() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/user"
        let perameters = [
            "name": nameTF.text!,
            "email": emailTF.text!,
            "fireBase_id" : "1212212",
            "password": passwordTF.text!
            
        ]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: perameters,
                   encoder: JSONParameterEncoder.default).response { response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        let decoder = JSONDecoder()
                        
                        do {
                            
                            let userModel = try decoder.decode(UserModel.self, from: data)
                            if userModel.status == true {
                                // move to next screen home
                                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isUserLogin.rawValue)
                                self.movetoHomeScreen()
                            } else {
                                // show error message
                                self.asqa_Alert(message: userModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
//Googole With login Api
extension RegisterVC {
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
