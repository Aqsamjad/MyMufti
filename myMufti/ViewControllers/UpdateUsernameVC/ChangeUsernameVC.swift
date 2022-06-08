//
//  ChangeUsernameVC.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class ChangeUsernameVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var changeUsernameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeUsernameBtn.layer.cornerRadius = 8
        roundTextView(textFeild: usernameTF)
        setUpTextField()
        self.usernameTF.text = nil
    }
    ///SetUp text on TextField
    func setUpTextField() {
        //get values form user default
        let userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue) ?? ""
        // set this value to usernameTF
        usernameTF.text = userName
    }
    //MARK: - TextField Empty Validation Function Call
    @IBAction func changeUsernameBtnAction(_ sender: Any) {
        if TextFeildsisEmpty() {
            // Show alert
            asqa_Alert(message: "Please Enter Tour Email")
        } else {
            // Move To next Screen
            callUpdateUsernameAPI()
        }
    }
    ///Function of TextFeilds Validation
    func TextFeildsisEmpty() -> Bool{
        // this func just check either textfields are empty or not
        if (usernameTF.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    /// Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "MyProfile", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK: - Api Function Call
    func callUpdateUsernameAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/userName"
        let  parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue),
            "name": usernameTF.text ,
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
                            
                            let usernameModel = try decoder.decode(UserModel.self, from: data)
                            
                            if usernameModel.status == true {
                                // move to next screen home
                                UserDefaults.standard.setValue(usernameTF.text, forKey: UserDefaultsKeys.userName.rawValue)
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                // show error message
                                self.asqa_Alert(message: usernameModel.message)
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                    
                   }
    }
}
//MARK: - Rounded Function
extension ChangeUsernameVC{
    func roundTextView(textFeild:UIView) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
}
