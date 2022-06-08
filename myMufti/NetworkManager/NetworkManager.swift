//
//  NetworkManager.swift
//  myMufti
//
//  Created by Qazi on 17/01/2022.

import Foundation
import Alamofire

class NetworkManager {
    
    static let standar = NetworkManager()
    
    func isInterNetworkConnected() -> Bool {
        if (NetworkReachabilityManager()?.isReachable)! {
            return true
        } else {
            return false
        }
    }
}
