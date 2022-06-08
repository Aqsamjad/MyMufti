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
    
    func uploadPictureOnStorageManager(myImage: UIImage, firebaseID: String) {
        
        guard let convertedImg = myImage.jpegData(compressionQuality : 0.0) else {
            
            return
        }
        
        let bse64 = convertedImg.base64EncodedString()
        
        print("converted image is: \(bse64)")
        //         let fileName = chatUSer.profilePictureFileName
        let fileName = "user_image\(firebaseID)"
        
        print("file name is: \(fileName)")
        StorageManager.shared.uploadProfilePicture(with: convertedImg, fileName: fileName, completion: { result in
            
            switch result {
                
            case .success(let downloadUrl):
                print("image url is \(downloadUrl)")
                
            case .failure(let error):
                
                print("storage manager error \(error)")
            }
            
        })
    }
    
    func downloadURLFromStorageManager(image: String, cell: UITableViewCell) {
        
//        let imageURL = "user_image\(image)"
//        let path = "Photos/\(imageURL)"
//        print("the url for image become: \(path)")
//        StorageManager.shared.downloadURL(for: path, completion: { result in
//            switch result {
//            case .success(let url):
//
////                DispatchQueue.main.async {
//                    cell.cellImg.sd_setImage(with: url, completed: nil)
////                }
//
//            case .failure(let error):
//                print("failed to get image url: \(error)")
//            }
//        })
    }
    
}
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
