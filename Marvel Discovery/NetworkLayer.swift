//
//  NetworkLayer.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 12/31/17.
//  Copyright © 2017 Nada Kamel. All rights reserved.
//

import Foundation
import Alamofire


class NetworkLayer {
    
    static var publicKey = "1f6d4c274a4933e9409e77c8067053e6"
    static var hash = "5b31c337393326e36841ed9276013ee6"            // md5(ts+privateKey+publicKey)

    class func getCharactersHTTPRequest (offset: Int, completion: @escaping (NSArray) -> () ) {
        let urlPath = "https://gateway.marvel.com/v1/public/characters?ts=1&apikey="+publicKey+"&hash="+hash+"&limit=6&offset=\(offset)"
        Alamofire.request(urlPath, method: .get, parameters: nil).responseJSON() { response in
            let statusCode = response.response?.statusCode
            if (statusCode == 200) {
                if let requestResponse = response.result.value {
                    let responseDict = requestResponse as! NSDictionary
                    let data = responseDict["data"] as! NSDictionary
                    let results = data["results"] as! NSArray
                    completion(results)
                }
            }
            else {
                let requestResponse = response.result.value as! NSDictionary
                let error = ["error" : requestResponse["message"]]
                completion([error])
            }
        }
    }
    
}

