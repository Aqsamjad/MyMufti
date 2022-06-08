//
//  ChatTableVC.swift
//  myMufti
//
//  Created by Qazi on 21/12/2021.
//

import UIKit

class ChatTableVC: UITableViewCell {
    
    
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var chatProfileImage: UIImageView!
    @IBOutlet weak var chatOnlineIcon: UIImageView!
    @IBOutlet weak var chatLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
//    @IBOutlet weak var onlineNotification: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
