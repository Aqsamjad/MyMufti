//
//  FullQuestionsTableViewCell.swift
//  myMufti
//
//  Created by Qazi on 23/02/2022.
//

import UIKit
import SDWebImage

class FullQuestionsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var commentCellView: UIView!
    @IBOutlet weak var commentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentView.layer.cornerRadius = 22.5
    }
    func bindData(aqsaCommentModel: UserComment) {
        nameLbl.text = aqsaCommentModel.userID
        commentLbl.text = aqsaCommentModel.comment
        let current = Calendar.current.dateComponents(in: .current, from: DateManager.standard.getDateFrom(stringDate: aqsaCommentModel.createdAt))
        if let currentHour = current.hour {
            let hoursTillMidnight = 24 - currentHour
            print(hoursTillMidnight)
            hoursLbl.text = String(hoursTillMidnight)
        }
//        commentImage.sd_setImage(with: URL(string: aqsaQuestionModel.userID), completed: nil)
        // setting yes and no percentages of the question votes.
    }
}
