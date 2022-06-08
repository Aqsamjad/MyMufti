//
//  TimerViewController.swift
//  signInDemo
//
//  Created by Qazi on 03/03/2022.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayMinutes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayMinutes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.fruitsTF.text = arrayMinutes[row]
    }
    private func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 36.0
        }

    private func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 36.0
        }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var fruitsTF: UITextField!
    var arrayMinutes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        arrayMinutes = ["0", "1", "2", "3" , "4", "5", "6" , "7", "8", "9" , "10", "11", "12", "13" , "14", "15", "16" , "17", "18", "19" , "20", "21", "22", "23" , "24", "25", "26" , "27", "28", "29" , "30","31", "32", "33" , "34", "35", "36" , "37", "38", "39" , "40", "41", "42", "43" , "44", "45", "46" , "47", "48", "49" , "50", "51", "52", "53" , "54", "55", "56" , "57", "58", "59" , "60"]
         self.pickerView.dataSource = self
         self.pickerView.delegate = self
        self.pickerView.isHidden = true
        self.view.addSubview(pickerView)
    }
}
