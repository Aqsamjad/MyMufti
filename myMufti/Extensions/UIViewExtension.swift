//
//  UIViewExtension.swift
//  MoToDo
//
//  Created by Rauf on 20/09/2021.
//

import Foundation
import UIKit

class RoundedViews: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.5
        
        }
}
class RoundedOnlyViews: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        
        }
}
class RoundedViewsWithoutShadow: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        }
   
}
class halfBottomRoundedViews: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
    }
}

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        }
}
class ImagesRoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 31.5
        }
}
class RoundedImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 32.5
        }
}
class smallRoundedImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 22
        }
}
class chatRoundedImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 24
        }
}
class LoveScRoundedImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 12.5
        }
}

class RoundedTxtFld: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.borderStyle = .none
        self.layer.cornerRadius = 15
        let color = UIColor(named: "primaryLightGray")
        self.layer.backgroundColor = color?.cgColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always

        }
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

class CheckBoxUsing : Checkbox {
    
    func checkbox(checkBox: Checkbox) {
        
        checkBox.checkedBorderColor = UIColor(red: 71/255, green: 88/255, blue: 65/255, alpha: 1)
        checkBox.uncheckedBorderColor = UIColor(red: 71/255, green: 88/255, blue: 65/255, alpha: 1)
       
        checkBox.borderStyle = .square
        checkBox.checkmarkColor = .white
        checkBox.checkmarkStyle = .tick
        checkBox.backgroundColor = .white
        checkBox.useHapticFeedback = true
       
        checkBox.checkmarkSize = 0.6
        
        checkBox.valueChanged = { (isChecked) in
            
            if isChecked == true {
            
            print("checkbox is checked: True")
            checkBox.backgroundColor = UIColor(red: 71/255, green: 88/255, blue: 65/255, alpha: 1)
            
            } else {
                
                checkBox.backgroundColor = .white
            }
       }
  }
}
extension String {
    func captalizeFirstCharacter() -> String {
        var result = self

        let substr1 = String(self[startIndex]).uppercased()
        result.replaceSubrange(...startIndex, with: substr1)

        return result
    }
}
