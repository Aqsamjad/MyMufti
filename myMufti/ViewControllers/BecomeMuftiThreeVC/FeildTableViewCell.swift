//
//  FeildTableViewCell.swift
//  myMufti
//
//  Created by Qazi on 12/02/2022.
//

import UIKit

class FeildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feildLbl: UILabel!
    @IBOutlet weak var feildView: UIView!
    @IBOutlet weak var checkBox: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(myView: feildView)
    }
}
//MARK:- Custom Function of Table View Rounded cell
extension FeildTableViewCell {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}
