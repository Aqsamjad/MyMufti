//
//  NotificationTableViewCell.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        roundView(myView: notificationView)
    }

}
//MARK:- Custom rounded View Function
extension NotificationTableViewCell {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}
