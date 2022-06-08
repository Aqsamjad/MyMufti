//  NotificationVC.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit

class NotificationVC: UIViewController {

    let images = ["mufti_1" , "mufti_2" , "" , "mufti_4"]
    let names =  ["Skndr bkht sent you message" , "Hassan answeres to your question" , "Your question time is over. Checkout the results." , "Ali commented on your question"]
    let timetext = ["Just Now" , "3 hours" , "1 day" , "1 day"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK:- Custom Function of Table View Cell
extension NotificationVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC") as! NotificationTableViewCell
        cell.notificationImage.image = UIImage(named: images[indexPath.row])
        cell.textLbl.text = names[indexPath.row]
        cell.discriptionLbl.text = timetext[indexPath.row]
        return cell
    }
    
  }
    

