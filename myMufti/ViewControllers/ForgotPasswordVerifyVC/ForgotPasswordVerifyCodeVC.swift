//
//  PasswordViewController.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit
import Alamofire
import SwiftSpinner

class ForgotPasswordVerifyCodeVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var passwordBtn: UIButton!
    
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var emailTextField: UILabel!
    
    var emailTF = ""
    var user_id = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backMainView.layer.cornerRadius = 20
        
        otp1.backgroundColor = UIColor.clear
        otp2.backgroundColor = UIColor.clear
        otp3.backgroundColor = UIColor.clear
        otp4.backgroundColor = UIColor.clear
        
        addBottomBorderTo(textField: otp1)
        addBottomBorderTo(textField: otp2)
        addBottomBorderTo(textField: otp3)
        addBottomBorderTo(textField: otp4)
        
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        
        otp1.becomeFirstResponder()
        
        emailTextField.text = emailTF
    }
    //MARK:- Next Btn is Empty Validation
    @IBAction func passwordNextBtnAction(_ sender: Any) {
        
        if isOTPTextFieldsAreEmpty() {
            // Show alert
            asqa_Alert(message: "Please Enter Your Code")
        } else {
            // Go on Next Screen
            callOTPVerifyAPI()
            print("Go on Next Screen")
        }
    }
    @IBAction func recentCodeDidTapped(_ sender: UIButton){
        callRecentCodeAPI()
    }
    //    MARK:- Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Custom Function of OTP
    func addBottomBorderTo(textField: UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 2.0)
        textField.layer.addSublayer(layer)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) {
            if textField == otp1 {
                otp2.becomeFirstResponder()
            }
            if textField == otp2 {
                otp3.becomeFirstResponder()
            }
            if textField == otp3 {
                otp4.becomeFirstResponder()
            }
            if textField == otp4 {
                otp4.resignFirstResponder()
            }
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0){
            if textField == otp2 {
                otp1.becomeFirstResponder()
            }
            if textField == otp3 {
                otp2.becomeFirstResponder()
            }
            if textField == otp4 {
                otp3.becomeFirstResponder()
            }
            if textField == otp1 {
                otp4.resignFirstResponder()
            }
            textField.text = ""
            return false
            
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
    //MARK:- Custom Function of OTP Empty Validation
    func isOTPTextFieldsAreEmpty() -> Bool {
        if (otp1.text!.isEmpty || otp2.text!.isEmpty || otp3.text!.isEmpty || otp4.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    // MARK:- Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "ForgotPasswordOTP", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    // MARK:- Move to VertifyCode Screen
    func userid(user_id: Int) {
        // var id: Int = user_id
    }
    func moveToChangePasswordScreen() {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        // email or user_id and set it on next screen.
        destinationViewController.id = user_id
        // destinationViewController.emailTF = emailTF.text!
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
    //    MARK: - Api Function Call
extension ForgotPasswordVerifyCodeVC {
    func callOTPVerifyAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/check_code"
        let otpCode = otp1.text! + otp2.text! + otp3.text! + otp4.text!
        let  parameter = [
            "email": emailTF,
            "code": otpCode
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
                            
                            let verifyOTPModel = try decoder.decode(UserModel.self, from: data)
                            
                            if verifyOTPModel.status == true {
                                user_id = verifyOTPModel.data?.id ?? ""
                                // move to next screen home
                                self.moveToChangePasswordScreen()
                            } else {
                                // show error message
                                self.asqa_Alert(message: verifyOTPModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                }
            }
         }
//    MARK:- Api Function Call
extension ForgotPasswordVerifyCodeVC {
func callRecentCodeAPI() {
    let baseURL = "http://mymufti.megaxtudio.com/Users/check_code"
    let otpCode = otp1.text! + otp2.text! + otp3.text! + otp4.text!
    let  parameter = [
        "email": emailTF,
        "code": otpCode
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
                        
                        let verifyOTPModel = try decoder.decode(UserModel.self, from: data)
                        
                        if verifyOTPModel.status == true {
                            user_id = verifyOTPModel.data?.id ?? ""
                            // move to next screen home
                            self.moveToChangePasswordScreen()
                        } else {
                            // show error message
                            self.asqa_Alert(message: verifyOTPModel.message)
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
     }
