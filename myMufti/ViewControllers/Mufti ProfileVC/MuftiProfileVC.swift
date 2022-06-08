//
//  MuftiProfileVC.swift
//  myMufti
//
//  Created by Qazi on 05/01/2022.
//

import UIKit

class MuftiProfileVC: UIViewController {
    
    @IBOutlet weak var instituteView: UIView!
    @IBOutlet weak var instituteNameTF: UITextField!
    @IBOutlet weak var phnNmbView: UIView!
    @IBOutlet weak var phnNmbrTF: UITextField!
    @IBOutlet weak var degreeView: UIView!
    @IBOutlet weak var degreeNameTF: UITextField!
    @IBOutlet weak var from1View: UIView!
    @IBOutlet weak var from1TF: UITextField!
    @IBOutlet weak var from2View: UIView!
    @IBOutlet weak var from2TF: UITextField!
    @IBOutlet weak var contactBTn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactBTn.layer.cornerRadius = 8
        roundView(myView: instituteView)
        roundView(myView: phnNmbView)
        roundView(myView: degreeView)
        roundView(myView: from1View)
        roundView(myView: from2View)
        
        self.from1TF.setDatePicker(target: self, selector: #selector(from1exp))
        self.from2TF.setDatePicker(target: self, selector: #selector(from2exp))
    }
    //MARK: - Next Btn Action
    @IBAction func contactBtnAction(_ sender: Any) {
        if isTextFeildAreEmpty() {
            asqa_Alert(message: "Please Fill All TextFields")
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK:- Function of TextFeilds Validation
    func isTextFeildAreEmpty() -> Bool {
        if (phnNmbrTF.text!.isEmpty || degreeNameTF.text!.isEmpty || instituteNameTF.text!.isEmpty || from1TF.text!.isEmpty || from2TF.text!.isEmpty) {
            return  true
        }else{
            return  false
        }
    }
    // MARK:- Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Mufti Profile", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK:- Custom Function  of Start Date Picker
    @objc func from1exp() {
        if let datePicker = self.from1TF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.from1TF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.from1TF.resignFirstResponder() // 2-5
    }
    //    MARK:- Custom Function  of End Date Picker
    @objc func from2exp() {
        if let datePicker = self.from2TF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.from2TF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.from2TF.resignFirstResponder() // 2-5
    }
//    func moveToLogInScreen() {
//        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
//        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "PreferencesVC") as! PreferencesVC
//        self.navigationController?.pushViewController(destinationViewController, animated: true)
//        
//    }
}
//MARK:- Custom Function Of Prefrences Rounded
extension MuftiProfileVC{
    func roundTextView(textFeild:UIView) {
        textFeild.layer.borderWidth = 1
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
}
extension MuftiProfileVC{
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}
// MARK: - UITextFieldDelegate
extension UITextField {
    func setDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func Cancel() {
        self.resignFirstResponder()
    }
    
}


