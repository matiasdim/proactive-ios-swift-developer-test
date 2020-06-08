//
//  NetworkManager.swift
//  SwiftTest
//
//  Created by Matías Gil Echavarría on 6/8/20.
//  Copyright © 2020 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NetworkManager: NSObject {
    static let sharedManager = NetworkManager()
    static let baseURL = "http://gl-endpoint.herokuapp.com"
    
    static func baseGetRequest(url: String, callback: @escaping (Any?) -> ()) {
        if let url = URL(string: url) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            urlRequest = try! JSONEncoding.default.encode(urlRequest, with: nil)
            
            AF.request(urlRequest).responseJSON { (response) in
                if let value = response.value {
                    callback(value)
                }
            }
        } else {
            callback(nil)
        }
    }
    
    ///Refactor for a generalcall including all httpmethods
    static func getRecipes(callback: @escaping (Any?) -> ()) {
        NetworkManager.baseGetRequest(url: "\(NetworkManager.baseURL)/recipes", callback: callback)
        
    }
    
    static func getRecipe(id: Int, callback: @escaping (Any?) -> ()) {
        NetworkManager.baseGetRequest(url: "\(NetworkManager.baseURL)/recipes/\(id)", callback: callback)
    }
    
    static func getRecipeImage(url: String, callback: @escaping (Any) -> ()) {
        AF.request(url).responseImage { (response) in
            if case .success(let _) = response.result {
                
                callback(response)
            } 
        }
    }

    
    static func isInternetReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
