//
//  PreferencesTableVCell.swift
//  myMufti
//
//  Created by Qazi on 04/01/2022.
//

import UIKit

class PreferencesTableVCell: UITableViewCell {

    @IBOutlet weak var preferencesView: UIView!
    @IBOutlet weak var prefrencesBtn: UIButton!
    @IBOutlet weak var preferencesImage: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var OnlineIconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(myView: preferencesView)
    }
}
//MARK:- Custom Function Of Rounded Table View cell
extension PreferencesTableVCell {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}
