//
//  HistoryVC.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class HistoryVC: UIViewController {
    
    
    
    let names = ["Skndr Bkht" , "Skndr Bkht"]
    let text = ["I want to give my Zakat to an Islamic Center, what should I do?" , "I want to give my Zakat to an Islamic Center, what should I do?"]
    let thirtytext = ["30%" , "30%"]
     let seventytext = ["70%" , "70%"]
    
    var historyModel: HistoryModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callHistoryAPI()
    }
    //  Funcion of TextFeilds Alert and Go on Next Screen
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Forgot Password", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
}
//MARK:- TableView Custom function
extension HistoryVC:UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return names.count
//    this will work for question collection view
             if historyModel != nil {
                 return (historyModel?.data.count)!
             } else {
                 return 0
             }
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell  = tableView.dequeueReusableCell(withIdentifier: "HistoryTVC") as! HistoryTViewCell
    cell.bindData(aqsaHistoryModel: (historyModel?.data[indexPath.row])!)
//    cell.textLbl.text = names[indexPath.row]
//    cell.textView.text = text[indexPath.row]
//    cell.thirtyLbl.text = thirtytext[indexPath.row]
//    cell.seventyLbl.text = seventytext[indexPath.row]
    return cell
  }
}
//MARK:- History API Call
extension HistoryVC {
    func callHistoryAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/history?user_id=146"
        SwiftSpinner.show("Loading...")
        AF.request(baseURL, method:.get, encoding: JSONEncoding.default,  headers: nil).responseData(completionHandler: {   response in
            switch response.result {
            case .success( _):
                SwiftSpinner.hide()
                let decoder = JSONDecoder()
                do {
                    print(String(data: response.data!, encoding: .utf8) as Any)
                    
                    self.historyModel = try decoder.decode(HistoryModel.self, from: response.data!)
                    
                    if self.historyModel?.status == true {
                        
                        print("History success")
//                        self.cView2.reloadData()
                    } else {
                        self.asqa_Alert(message: self.historyModel?.message ?? "Question Model Error")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                SwiftSpinner.hide()
                print(error.localizedDescription)
            }
        })
    }
}


