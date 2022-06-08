//
//  Navigation.swift
//  LoveNLead
//
//  Created by Ammar on 11/15/21.
//

import Foundation
import UIKit

extension UIViewController  {
    
    func navigateToControllers(name: String, identifier: String) {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func presentTheController(name: String, identifier: String) {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        self.navigationController?.present(vc, animated: true)
    }
    
    func popVC() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
    
extension UINavigationController {
    
//    this function will pop to specific view controller
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
