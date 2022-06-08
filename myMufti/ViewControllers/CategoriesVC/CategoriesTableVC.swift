//
//  CategoriesTableVC.swift
//  myMufti
//
//  Created by Qazi on 04/01/2022.
//

import UIKit

class CategoriesTableVC: UITableViewCell {
    
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(myView: categoriesView)
    }
}
//MARK:- Custom Function Table View Cell Rounded Function
extension CategoriesTableVC {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}

