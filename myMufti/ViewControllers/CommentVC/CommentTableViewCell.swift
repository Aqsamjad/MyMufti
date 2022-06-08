//
//  CommentTableViewCell.swift
//  myMufti
//
//  Created by Qazi on 25/02/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var commentCellView: UIView!
    @IBOutlet weak var commentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        commentView.layer.cornerRadius = 22.5
        roundView(myView: commentCellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
extension CommentTableViewCell {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 10
    }
}
