//
//  ChatVC.swift
//  myMufti
//
//  Created by Qazi on 17/12/2021.
//

import UIKit

class ChatVC: UIViewController {
    
    let images = ["mufti_1" , "mufti_2" , "mufti_3"]
    let names = ["Mufti Hassan" , "Mufti Ali" , "Mufti Qasim"]
    let chatDiscription = ["Good morning, did you sleep well?" , "How is it going?" , "Aight, noted"]
    let images1 = ["online_icon" ,"online_icon" , "online_icon"]
    let dayDate = ["Today" , "17/6" , "17/6"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: - Custom Function Of TableView.

extension ChatVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableVC") as! ChatTableVC
        cell.chatProfileImage.image = UIImage(named: images[indexPath.row])
        cell.chatLbl.text = names[indexPath.row]
        cell.descriptionLbl.text = chatDiscription[indexPath.row]
        cell.chatOnlineIcon.image = UIImage(named: images1[indexPath.row])
        cell.notificationLbl.text = dayDate[indexPath.row]
        //cell.onlineNotification.image = UIImage(named: notifyimages[indexPath.row])
        return cell
    }
}



