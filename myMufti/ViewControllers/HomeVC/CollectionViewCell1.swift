//
//  CollectionViewCell1.swift
//  myMufti
//
//  Created by Qazi on 10/02/2022.
//

import UIKit

class CollectionViewCell1: UICollectionViewCell {
    
    @IBOutlet weak var namazImages: UIImageView!
    @IBOutlet weak var namazNames: UILabel!
    @IBOutlet weak var namazTiming: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        namazImages.layer.borderWidth = 6
        namazImages.layer.borderColor = UIColor.white.cgColor
        namazImages.layer.cornerRadius = 43
//        setGradientBackground()
    }
}
//MARK:- Custom Function Of GradiantColor
extension CollectionViewCell1 {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 117.0/255.0, green: 168.0/255.0, blue: 130.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 117.0/255.0, green: 168.0/255.0, blue: 130.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.contentView.bounds
                
        self.contentView.layer.insertSublayer(gradientLayer, at:0)
    }
}
