//
//  PreferencesVC.swift
//  myMufti
//
//  Created by Qazi on 03/01/2022.
//

import UIKit

class PreferencesVC: UIViewController {
    
    let images = ["mufti_1" , "mufti_2"]
    let names = ["Mufti Hassan" , "Mufti Ali"]
    let text = ["Marriage, Family Law and Duas" , "Marriage, Family Law and Duas"]
    let image = ["greenIcon" , "greenIcon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //    MARK:- muftiProfile Btn Action
    @IBAction func muftiProfileTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "MuftiProfileVC") as! MuftiProfileVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
       
    }
}
//MARK:- Custom Function Of Table View Cell
extension PreferencesVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "PreferencesTVC") as! PreferencesTableVCell
        cell.preferencesImage.image = UIImage(named: images[indexPath.row])
        cell.textLbl.text = names[indexPath.row]
        cell.discriptionLbl.text = text[indexPath.row]
        cell.OnlineIconImage.image = UIImage(named: image[indexPath.row])
        return cell
    }
}
