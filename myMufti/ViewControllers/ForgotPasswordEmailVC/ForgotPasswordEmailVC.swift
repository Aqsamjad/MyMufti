//
//  ForgotPasswordEmailVC.swift
//  myMufti
//
//  Created by Qazi on 29/01/2022.
//

import UIKit
import Alamofire
import SwiftSpinner

class ForgotPasswordEmailVC: UIViewController {
    

    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var forgotPasswordNextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backMainView.layer.cornerRadius = 20
        roundTextView(textFeild: emailTF)
    }
//MARK:- Custom Function of TextField Validation is Empty or Not
    @IBAction func forgotPasswordNextBtnAction(_ sender: Any) {
        if isTextFeildAreEmpty() {
//            Show Alert Feild are empty
            asqa_Alert(message: "Please Enter Your Email.")
        } else {
            let isEmailValid = isValidEmailAddress(emailAddressString: emailTF.text!)
            if isEmailValid {
                // call network api
                if NetworkManager.standar.isInterNetworkConnected(){
                    callForgotPasswordEmailAPI()
                } else {
                    asqa_Alert(message: "Please connect internet")
                }
                
            } else {
//                Show alert Email is not Valid
                asqa_Alert(message: "email address is not Valid")
            }
        }
    }
    //    MARK:- Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFeildAreEmpty() -> Bool {
        if (emailTF.text!.isEmpty) {
            return  true
        }else{
            return  false
        }
    }
    //     MARK:- Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Forgot Password Email", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //MARK:- Function of  Email Validation
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
//MARK: - Move to VertifyCode Screen
    func moveToOTPVerfiyScreen() {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVerifyCodeVC") as! ForgotPasswordVerifyCodeVC
        // email and set it on next screen.

        destinationViewController.emailTF = emailTF.text!
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //    MARK: - Api Function Call
    func callForgotPasswordEmailAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/forgot_password_email"
        let  parameter = [
            "email": emailTF.text!,
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
                            
                            let forgotPasswordModel = try decoder.decode(GeneralResponseModel.self, from: data)
                            if forgotPasswordModel.status == true {
                                // move to next screen home
                                self.moveToOTPVerfiyScreen()
                            } else {
                                // show error message
                                self.asqa_Alert(message: forgotPasswordModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
               
            }
    }
}
//MARK: - Custom Function of Rounded textFeild
extension ForgotPasswordEmailVC{
    func roundTextView(textFeild:UITextField) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
}
