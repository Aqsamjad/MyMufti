//
//  UpdatePasswordVC.swift
//  myMufti
//
//  Created by Qazi on 07/02/2022.
//

import UIKit
import Alamofire
import SwiftSpinner

class UpdatePasswordVC: UIViewController {
    
    @IBOutlet weak var retypePasswordTF: UITextField!
    @IBOutlet weak var updatePasswordBTn: UIButton!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var oldPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTextView(textFeild: oldPasswordTF)
        roundTextView(textFeild: newPasswordTF)
        roundTextView(textFeild: retypePasswordTF)
    }
    @IBAction func updatePasswordBtnAction(_ sender: Any) {
        if isTextFeildAreEmpty() {
            asqa_Alert(message: "Please Enter Your password")
        } else {
            // move on next screen
            if (oldPasswordTF.text!.count < 6 || newPasswordTF.text!.count < 6 || retypePasswordTF.text!.count < 6) {
                asqa_Alert(message: "password legth is must be 6 Character")
            } else {
                if oldPasswordTF == UserDefaults.standard.string(forKey: UserDefaultsKeys.password.rawValue)! as NSObject {
                    true
                    asqa_Alert(message: "Password is not changed")
                } else {
                    if newPasswordTF.text != retypePasswordTF.text {
                        asqa_Alert(message: "Password is Not Match")
                    }else {
                        // move on Home screen
                        callUpdatePasswordAPI()
                    }
                }
            }
        }
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFeildAreEmpty() -> Bool {
        if (oldPasswordTF.text!.isEmpty || newPasswordTF.text!.isEmpty || retypePasswordTF.text!.isEmpty) {
            return  true
        }else{
            return  false
        }
    }
    // MARK:- Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "MyProfile", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK:- Api Function Call
    func callUpdatePasswordAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/change_password"
        let  parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue),
            "password": newPasswordTF.text!
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
                            
                            let updatePasswordModel = try decoder.decode(GeneralResponseModel.self, from: data)
                            
                            if updatePasswordModel.status == true {
                                // move to next screen home
                                UserDefaults.standard.setValue(newPasswordTF.text, forKey: UserDefaultsKeys.password.rawValue)
                                self.navigationController?.popToRootViewController(animated: true)
                            } else {
                                // show error message
                                self.asqa_Alert(message: updatePasswordModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                    
                   }
    }
}
//MARK: - Custom Function of Rounded textFeild
extension UpdatePasswordVC{
    func roundTextView(textFeild:UITextField) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
}
