//
//  CategoriesVC.swift
//  myMufti
//
//  Created by Qazi on 04/01/2022.
//

import UIKit

class CategoriesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = [Int]()
    
    let categories = ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    var selectedCategories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //    Function Of Selectd Categories
    func addselectedCategories() {
        for tempIndex in selectedIndex {
            selectedCategories.append(categories[tempIndex])
        }
    }
    //Function Of CheckBoxb Action
    @objc func checkboxClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if selectedIndex.contains(sender.tag) {
            selectedIndex.remove(at: selectedIndex.firstIndex(of: sender.tag) ?? -1)
        } else {
            selectedIndex.append(sender.tag)
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
//MARK: - Custom Function Extension
extension CategoriesVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTVC") as! CategoriesTableVC
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkboxClicked(_ :)), for: .touchUpInside)
        cell.checkBox.isSelected = false
        //  CheckBox SelectedItems Conditions
        if selectedIndex.contains(indexPath.row) {
            cell.checkBox.isSelected = true
        }
        cell.categoriesLbl.text = categories[indexPath.row]
        return cell
    }
}

