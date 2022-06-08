//
//  ForgotPasswordaViewController.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit
import Alamofire
import SwiftSpinner

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var retypePasswordTF: UITextField!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backMainView.layer.cornerRadius = 20
        forgotPasswordBtn.layer.cornerRadius = 8
        roundTextView(textFeild: passwordTF)
        roundTextView(textFeild: retypePasswordTF)
        print(id)
    }
    //MARK: - Next Btn Action
    @IBAction func changePasswordBtnAction(_ sender: Any) {
        if isTextFeildAreEmpty() {
            asqa_Alert(message: "Please Enter Your password")
        } else {
            // move on next screen
            if (passwordTF.text!.count < 6 || retypePasswordTF.text!.count < 6) {
                asqa_Alert(message: "password legth is must be 6 Character")
            } else {
                if passwordTF.text != retypePasswordTF.text {
                    asqa_Alert(message: "Password is Not Match")
                }else {
                    // move on Home screen
                    callChangePasswordAPI()
                    
                }
                
            }
        }
    }
    //    MARK:- Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFeildAreEmpty() -> Bool {
        if (passwordTF.text!.isEmpty || retypePasswordTF.text!.isEmpty) {
            return  true
        }else{
            return  false
        }
    }
    // MARK:- Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Forgot Password", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    func moveToLogInScreen() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        //        destinationViewController.restorationIdentifier = id
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //    MARK: - Api Function Call
    func callChangePasswordAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/change_password"
        let  parameter = [
            "user_id": id,
            "password": passwordTF.text!
        ]
        
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .put,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default).response { [self] response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        print(String(data: data, encoding: .utf8) as Any)
                        let decoder = JSONDecoder()
                        
                        do {
                            
                            let changePasswordModel = try decoder.decode(GeneralResponseModel.self, from: data)
                            
                            if changePasswordModel.status == true {
                                // move to next screen home
                                self.navigationController?.popToRootViewController(animated: true)
                            } else {
                                // show error message
                                self.asqa_Alert(message: changePasswordModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                    
            }
    }
}
//MARK: - Custom Function of Rounded textFeild
extension ChangePasswordVC{
    func roundTextView(textFeild:UITextField) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
}
