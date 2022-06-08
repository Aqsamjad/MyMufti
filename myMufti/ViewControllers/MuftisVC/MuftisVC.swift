//
//  MuftisVC.swift
//  myMufti
//
//  Created by Qazi on 17/12/2021.
//

import UIKit

class MuftisVC: UIViewController {

    let images = ["mufti_1" , "mufti_2"]
    let names = ["Mufti Hassan" , "Mufti Ali"]
    let descreption = ["Marriage, Family Law and Duas" , "Marriage, Family Law and Duas"]
    let image1 = ["online_icon" , "online_icon"]
    
    
//    let names = ["Hassan", "Tariq"]
//    let discription = ["Test discription", " Test2 discription"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
//MARK: - Custom function
extension MuftisVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuftiProfileTVC") as! MuftiProfileTVC
        cell.profileImg.image = UIImage(named: images[indexPath.row])
        cell.nameLbl.text = names[indexPath.row]
        cell.descriptionLbl.text = descreption[indexPath.row]
        cell.onlineImage.image = UIImage(named: image1[indexPath.row])
        return cell
        
    }

}
