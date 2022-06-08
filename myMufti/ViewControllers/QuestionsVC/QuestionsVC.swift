//
//  MyViewController.swift
//  myMufti
//
//  Created by Qazi on 13/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class QuestionsVC: UIViewController {
    
    @IBOutlet weak var questionsCVC: UICollectionView!
    @IBOutlet weak var cView1: UICollectionView!
    
    var question_id = ""
    var fullQuestionModel: FullQuestionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callQuestionsAPI()
    }
    //MARK: - Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func moveToFullQuestionScreen()  {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "FullQuestionVC") as! FullQuestionVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Questions", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
}
//MARK: - Custom Function Of Collection View Cell data source
extension QuestionsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fullQuestionModel?.data.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionsCVC.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCell", for: indexPath) as! QuestionsCollectionViewCell
        cell.bindData(aqsaQuestionModel: (fullQuestionModel?.data[indexPath.row])!)
        return cell
    }
}
//MARK: - Delegate Methods
extension QuestionsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected screen")
        // get id slected tapquestion_id ped cell id.
        question_id  = (self.fullQuestionModel?.data[indexPath.row].questionID)!
        print(question_id as Any)
        moveToFullQuestionScreen()
    }
}
//MARK: - Dashboard API on Collection View Cell
extension QuestionsVC {
    func callQuestionsAPI() {
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
                        self.cView1.reloadData()
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
