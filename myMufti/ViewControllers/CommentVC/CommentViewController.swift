//
//  CommentViewController.swift
//  myMufti
//
//  Created by Qazi on 25/02/2022.
//

import UIKit

class CommentViewController: UIViewController {
    let images = ["comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image"]
    let names =  ["Aqsa Amjad" , "Kausar Razaq" , "Numra Sakeena" , "Adeela" , "Ayesha" , "Aqsa Amjad" , "Kausar Razaq" , "Numra Sakeena" , "Adeela" , "Ayesha"]
    let comment = ["My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment"]
    let hours = ["2 h" , "2 h" , "2 h" , "2 h" , "2 h" , "2 h" , "2 h" , "2 h" , "2 h" , "2 h"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//  MARK: - Custom Function Of Table View Cell
extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        cell.commentImage.image = UIImage(named: images[indexPath.row])
        cell.nameLbl.text = names[indexPath.row]
        cell.commentLbl.text = comment[indexPath.row]
        cell.hoursLbl.text = hours[indexPath.row]
        return cell
    }
}
//extension UITableView{
//    func setInputViewDatePicker(target: Any, selector: Selector) {
////        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
////        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
////        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
////        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
////    }
//       @objc func tapCancel() {
//        self.resignFirstResponder()
//    }
//  }
//}
