//
//  ProfileVC.swift
//  myMufti
//
//  Created by Qazi on 17/12/2021.
import UIKit
import Alamofire
import SwiftSpinner
import SDWebImage
enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
class ProfileVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    @IBOutlet weak var profileImgBTn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    var image = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = 40
        
        if let imageURL = UserDefaults.standard.string(forKey: UserDefaultsKeys.profile_Image.rawValue) {
            profileImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "person_placeholder"))
            
//            profileNameLbl.text = UserDefaultsKeys.userName.rawValue
        }
    }
//MARK:- Custom Function Of View Will Apear
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillAppear")
        let profileName = UserDefaults.standard.value(forKey: UserDefaultsKeys.userName.rawValue)
        if profileName != nil {
            profileNameLbl.text = UserDefaults.standard.value(forKey: UserDefaultsKeys.userName.rawValue) as? String
        } else {
            asqa_Alert(message: "ProfileName is not Updated")
        }
        print("profile will load")
    }
    //    MARK: - LogOut @IBAction
    @IBAction func didTapLogout(_ sender: Any) {
        // remove all the userDefauls
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isUserLogin.rawValue)
        // change the root to SignUpNav
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let SignUpNav = storyboard.instantiateViewController(identifier: "SignUpNav")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SignUpNav)
    }
    //MARK:- Update Username Btn Function
    @IBAction func changeUsernameBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "ChangeUsernameVC") as! ChangeUsernameVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- Update Password Btn Action
    @IBAction func updatePasswordBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "UpdatePasswordVC") as! UpdatePasswordVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- NotificationVC Btn Action
    @IBAction func notificationBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- HistoryVC Btn Action
    @IBAction func historyBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- PreferencesVC Btn Action
    @IBAction func prefrencesBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "PreferencesVC") as! PreferencesVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- categoriesVC Btn Action
    @IBAction func categoriesBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK:- categoriesVC Btn Action
    @IBAction func shareInviteBtnAction(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my app"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = shareBtn
            self.present(activityVC, animated: true, completion: nil)
        }
    
    }
    //    MARK:- Profile Image from Gallery Btn Action
    @IBAction func profileImageBtnAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("Camera Not Available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
//    MARK:- Custom Function Image Picker From Gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.contentMode = .scaleToFill
        profileImage.image = image
        picker.dismiss(animated: true) { [self] in
            self.callUpdateProfileImageAPI()
        }
        // picker.dismiss(animated: true, completion: nil)
    }
    //    MARK:- Custom Function Image Picker Controller Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "MyProfile", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK: - Api Function Call
    func callUpdateProfileImageAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/userImage"
//        //Now use image to create into NSData format
//        let imageData:NSData = profileImage.image!.pngData()! as NSData
//        // convert image into base64String
//        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//        // compress image before send it to server
        
        //compress image before send it to server
        let myImg = self.profileImage.image
        guard myImg != nil else {print("no Image selected");return}
        let reducedImg = myImg?.resizedTo1MB()
        
        // convert image into base64String
        guard let compressedImage = reducedImg?.jpegData(compressionQuality : 0.0)
        else {print("image not compressed");return}
        let CompressedImg = compressedImage.base64EncodedString()
        
        // print(CompressedImg)
        image = CompressedImg
        let  parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue),
            "image": CompressedImg
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
