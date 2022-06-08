//
//  FullQuestionVC.swift
//  myMufti
//
//  Created by Qazi on 05/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class FullQuestionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentTF:UITextField!
    @IBOutlet weak var muftiTF: UITextField!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var stackMufti: UIStackView!
    @IBOutlet weak var stackCmments: UIStackView!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    var fullQuestionModel: FullQuestionModel?
    var userCommentModel: UserCommentModel?
    
    var question_id = ""
    var votes = ""

    // Table View Declare
    var images = ["comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image"]
    var names =  ["Aqsa Amjad" , "Kausar Razaq" , "Numra Sakeena" , "Adeela" , "Ayesha"]
    var comment = ["My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment"]
    var hours = ["2 h" , "2 h" , "2 h" , "2 h" , "2 h"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        callFullQuestionsAPI()
//        callVotesAPI()
//        self.navigationItem.leftBarButtonItem = self.editButtonItem;
//        text field hidden time limit
        let secondsToDelay = 5.0

        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) { [self] in
           print("This message is delayed")
            UIView.animate(withDuration: 1) { [self] in
                stackMufti.isHidden = true
                stackCmments.isHidden = false
//                seeAllBtn.isHidden = false
                
                print(question_id)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //    MARK:- Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK:- Comment Btn Action
    @IBAction func commentBtnAction(_ sender: Any) {
        callUserCommentAPI()
    }
    //MARK: - Custom Function
    @IBAction func shareBtn(_ sender: Any) {
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
}
// MARK: - Rounded Text Feild Custom Function
extension FullQuestionVC{
    func roundTextView(textFeild:UIView) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.systemGreen.cgColor
    }
}
//MARK: - Rounded Function
extension FullQuestionVC{
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 22
    }
}
////    MARK: - Custom Function Of Collection View Cell
//extension FullQuestionVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return fullQuestionModel?.data.count ?? 0
//
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FullQuestionsCollectionViewCell", for: indexPath) as! FullQuestionsCollectionViewCell
//        cell.bindData(aqsaQuestionModel: (fullQuestionModel?.data[indexPath.row])!)
//        return cell
//    }
//}
//// MARK: - Collection View Delegate Methods
//extension FullQuestionVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("selected screen")
//        // get id slected tapquestion_id ped cell id.
//        question_id  = (self.fullQuestionModel?.data[indexPath.row].questionID)!
//        print(question_id as Any)
//    }
//}
//  MARK: - Custom Function Of Table View Cell
extension FullQuestionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullQuestionsTableViewCell") as! FullQuestionsTableViewCell
//        cell.bindData(aqsaCommentModel: (userCommentModel?.data[indexPath.row]))
        cell.commentImage.image = UIImage(named: images[indexPath.row])
        cell.nameLbl.text = names[indexPath.row]
        cell.commentLbl.text = comment[indexPath.row]
        cell.hoursLbl.text = hours[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    // Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Become A Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
}
//MARK: - Custom Function Of UserComment API
extension FullQuestionVC {
    func callUserCommentAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/comment"
        let parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) as Any,
            "question_id": question_id,
            "comment": commentTF.text as Any
        ] as [String : Any]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter).response { [self] response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        print(String(data: data, encoding: .utf8) as Any)
                        let decoder = JSONDecoder()
                        do {
                            let userCommentModel = try decoder.decode(UserCommentModel.self, from: data)
                            self.tableView.reloadData()
                            if userCommentModel.status == true {
                                self.tableView.reloadData()
                                // move to next screen home
                            } else {
                                // show error message
                                self.asqa_Alert(message: userCommentModel.message)
                            }
                        } catch let error {
                            print(error)
                        }
                    }
                }
             }
    }
//MARK: - Dashboard API on Collection View Cell
extension FullQuestionVC {
    func callFullQuestionsAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/question"
        SwiftSpinner.show("Loading...")
        AF.request(baseURL, method:.get, encoding: JSONEncoding.default,  headers: nil).responseData(completionHandler: {   response in
            switch response.result {
            case .success( _):
                SwiftSpinner.hide()
                let decoder = JSONDecoder()
                do {
                    print(String(data: response.data!, encoding: .utf8) as Any)

                    self.fullQuestionModel = try decoder.decode(FullQuestionModel.self, from: response.data!)

                    if self.fullQuestionModel?.status == true {

                        print("success")
//                        self.cView1.reloadData()
                    } else {
                        self.asqa_Alert(message: self.fullQuestionModel?.message ?? "Question Model Error")
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                SwiftSpinner.hide()
                print(error.localizedDescription)
            }
        })
    }
}
//MARK: - Custom Function Of UserComment API
extension FullQuestionVC {
    func callMuftiAnswerAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/answer"
        let parameter = [
            "mufti_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) as Any,
            "question_id": question_id,
            "answer": muftiTF.text! as Any
        ] as [String : Any]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter).response { [self] response in
                    if let data = response.data {
                        SwiftSpinner.hide()
                        print(String(data: data, encoding: .utf8) as Any)
                        let decoder = JSONDecoder()
                        do {
                            let userCommentModel = try decoder.decode(UserCommentModel.self, from: data)
                            self.tableView.reloadData()
                            if userCommentModel.status == true {
                                // move to next screen home
                            } else {
                                // show error message
                                self.asqa_Alert(message: userCommentModel.message)
                            }
                        } catch let error {
                            print(error)
                        }
                    }
                }
             }
    }
