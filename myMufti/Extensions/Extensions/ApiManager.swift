//
//  WebServices.swift
//  Qarinli
//
//  Created by Taimoor Arif on 08/09/2021.
//  Copyright © 2020 Abdur Rauf. All rights reserved.

import Foundation
import Alamofire

// clouser
typealias apiSuccess = (_ data: Data) -> ()
typealias apiFailure = (_ errorString: String) -> ()
typealias HTTPfailure = (_ errorString: String) -> ()


struct ApiResponse<T: Codable>: Codable {
    let status, response_message , reponse_type , message : String?
    let success : Bool?
    let data: T?
    var token = ""
}

class ApiManager {
    
    static let baseUrl = "http://loveandlead.megaxtudio.com/index.php/"
    
    class func URLResponse(_ url:String, method: HTTPMethod ,parameters: [String: Any]?, headers: String?,  withSuccess success: @escaping apiSuccess, withapiFiluer failure: @escaping apiFailure) {
        
        var completeUrl : String = baseUrl + url
        completeUrl = completeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? completeUrl
        print(completeUrl)
        
        let headersToken: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Accept": "application/json"
            
        ]

        AF.request(completeUrl, method:method, parameters: parameters, encoding: JSONEncoding.default,  headers:headersToken).validate(statusCode: 200..<600).responseData(completionHandler: {   response in
            switch response.result {
                
            case .success(let value):
                print(response.result)
                success(value)
                
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
    
}

