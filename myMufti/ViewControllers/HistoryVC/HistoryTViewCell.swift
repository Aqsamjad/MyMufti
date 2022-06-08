//
//  HistoryTViewCell.swift
//  myMufti
//
//  Created by Qazi on 04/01/2022.
//

import UIKit

class HistoryTViewCell: UITableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var thirtyLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var seventyLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(myView: historyView)
    }
    func bindData(aqsaHistoryModel: History) {
        textLbl.text = aqsaHistoryModel.userID
        textLbl.text = aqsaHistoryModel.questionID
        textLbl.text = aqsaHistoryModel.question.rawValue
        textView.text = aqsaHistoryModel.questionTitle.rawValue
        thirtyLbl.text = aqsaHistoryModel.options
        seventyLbl.text = aqsaHistoryModel.options
//        historyView.tag = aqsaHistoryModel.self
        
//        muftiNames.text = aqsaQuestionModel.userID.name
//        muftiDisTextView.text = aqsaQuestionModel.questionTitle
//        muftiDays.text = aqsaQuestionModel.createdAt
//        remainigLbl.text = aqsaQuestionModel.timeLimit
//        hoursLbl.text = aqsaQuestionModel.options
//        votesLbl.text = aqsaQuestionModel.userVote
//        
    }
}
//MARK:- Rounded Custom Function
extension HistoryTViewCell {
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}


